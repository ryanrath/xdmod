<?php

namespace CCR\Security\Authenticators;

use CCR\Configuration\IniConfiguration;
use CCR\Entity\User;
use CCR\Mail\NotificationMailerInterface;
use Exception;
use Models\Services\Organizations;
use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Security\Core\Exception\UserNotFoundException;
use Symfony\Component\Security\Http\Authenticator\AbstractAuthenticator;
use Symfony\Component\Security\Http\Authenticator\AuthenticatorInterface;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;
use Symfony\Component\Security\Http\Authenticator\Passport\SelfValidatingPassport;
use Symfony\Component\Security\Http\EntryPoint\AuthenticationEntryPointInterface;
use Symfony\Component\Security\Http\HttpUtils;
use Symfony\Component\DependencyInjection\ParameterBag\ContainerBagInterface;

use SimpleSAML\Auth\Source;

use XDUser;

class SimpleSamlPhpAuthenticator extends AbstractAuthenticator implements AuthenticatorInterface, AuthenticationEntryPointInterface
{
    private LoggerInterface $logger;

    private HttpUtils $httpUtils;

    private UrlGeneratorInterface $urlGenerator;


    private array $sources;

    private string $authSourceName;
    private \SimpleSAML\Auth\Simple $authSource;

    private ContainerBagInterface $parameters;

    const BASE_ADMIN_EMAIL = <<<EML

Person Details -----------------------------------
Name:              %s
Username:          %s
E-Mail:            %s

SAML Attributes ----------------------------------
%s

Notes: -------------------------------------------

Unable to Identify Users Organization.

Additional Setup Required.
EML;

    public function __construct(LoggerInterface $logger, HttpUtils $httpUtils, UrlGeneratorInterface $urlGenerator, ContainerBagInterface $parameters, protected IniConfiguration $portalSettings, private NotificationMailerInterface $notificationMailer)
    {
        $this->logger = $logger;
        $this->httpUtils = $httpUtils;
        $this->urlGenerator = $urlGenerator;
        $this->parameters = $parameters;

        $this->sources = Source::getSources();
        $this->logger->debug('Auth Sources', [$this->sources]);
        if (!empty($this->sources)) {
            try {
                $authSource = \xd_utilities\getConfiguration('authentication', 'source');
                $this->logger->debug('Found Auth Source', [$authSource]);
            } catch (\Exception $e) {
                $authSource = null;
            }
            if (!is_null($authSource) && array_search($authSource, $this->sources) !== false) {
                $this->authSourceName = $authSource;
                $this->authSource = new \SimpleSAML\Auth\Simple($authSource);
            } else {
                $this->authSourceName = $this->sources[0];
                $this->authSource = new \SimpleSAML\Auth\Simple($this->authSourceName);
            }
        }
    }


    /**
     * Determine whether or not this authenticator supports the provided $request.
     *
     * @param Request $request
     * @return bool|null
     * @throws \Psr\Container\ContainerExceptionInterface
     * @throws \Psr\Container\NotFoundExceptionInterface
     */
    public function supports(Request $request): ?bool
    {
        // We only allow SSO Auth when the request is a GET for the home page.
        if (!$request->isMethod('GET') ||
            !$this->httpUtils->checkRequestPath($request, 'xdmod_home')) {
            return false;
        }

        $referer = $request->headers->get('Referer');
        // And if the referer is not empty.
        if (empty($referer)) {
            return false;
        }

        $authReferrer = $this->portalSettings->getConfigurationOption('sso', 'auth_referer');
        $generalSiteAddress = $this->portalSettings->getConfigurationOption('general', 'site_address');
        if (empty($authReferrer) && !empty($generalSiteAddress)) {
            $authReferrer = sprintf(
                '%s/simplesaml/module.php/authoauth2/linkback.php',
                $generalSiteAddress
            );
        }
        return str_starts_with($referer, $authReferrer);
    }

    public function authenticate(Request $request): Passport
    {
        if ($this->authSource->isAuthenticated()) {
            $attributes = $this->authSource->getAttributes();
            $username = $attributes['username'][0];
            $logger = $this->logger;
            return new SelfValidatingPassport(
                new UserBadge(
                    $username,
                    function ($userName, $samlAttributes) use ($logger) {
                        $logger->debug('Loading SimpleSAMLPHP User');

                        $xdmodUserId = \XDUser::userExistsWithUsername($userName);
                        $logger->debug('XDMoD UserID ', [$xdmodUserId]);
                        if ($xdmodUserId !== INVALID) {
                            $user = \XDUser::getUserByID($xdmodUserId);
                            $user->setSSOAttrs($samlAttributes);
                            return User::fromXDUser($user);
                        }
                        $logger->debug('Creating New SSO User!');
                        // If we've gotten this far then we're creating a new user. Proceed with gathering the
                        // information we'll need to do so.
                        $emailAddress = isset($samlAttributes['email_address']) ? $samlAttributes['email_address'][0] : NO_EMAIL_ADDRESS_SET;
                        $systemUserName = isset($samlAttributes['system_username']) ? $samlAttributes['system_username'][0] : $userName;
                        $firstName = isset($samlAttributes['first_name']) ? $samlAttributes['first_name'][0] : 'UNKNOWN';
                        $middleName = isset($samlAttributes['middle_name']) ? $samlAttributes['middle_name'][0] : null;
                        $lastName = isset($samlAttributes['last_name']) ? $samlAttributes['last_name'][0] : null;
                        $personId = \DataWarehouse::getPersonIdFromPII($systemUserName, $samlAttributes['organization'][0]);

                        // Attempt to identify which organization this user should be associated with. Prefer
                        // using the personId if not unknown, then fall back to the saml attributes if the
                        // 'organization' property is present, and finally defaulting to the Unknown organization
                        // if none of the preceding conditions are met.
                        $userOrganization = $this->getOrganizationId($samlAttributes, $personId);

                        try {
                            $newUser = new \XDUser(
                                $userName,
                                null,
                                $emailAddress,
                                $firstName,
                                $middleName,
                                $lastName,
                                array(ROLE_ID_USER),
                                ROLE_ID_USER,
                                $userOrganization,
                                $personId,
                                $samlAttributes
                            );
                        } catch (\Exception $e) {
                            throw new \Exception('An account is currently configured with this information, please contact an administrator.');
                        }

                        $newUser->setUserType(SSO_USER_TYPE);

                        try {
                            $newUser->saveUser();
                        } catch (\Exception $e) {
                            $this->logger->error('User creation failed: ' . $e->getMessage());
                            throw $e;
                        }

                        $this->handleNotifications($newUser, $samlAttributes);

                        return User::fromXDUser($newUser);
                    },
                    $attributes
                )
            );
        }
        throw new UserNotFoundException();
    }

    /**
     * Attempt to retrieve an organization id, first with $personId, if it's valid ( !=== -1 ), and then with
     * $samlAttributes['organization'] if it exists. If both of those fail then -1 is returned ( Which corresponds with
     * the Unknown Organization)
     *
     * @param array $samlAttributes the attributes returned by SimpleSAMLphp
     * @param int $personId the id of the person whose organization we're looking for.
     * @return int the id of the organization
     * @throws Exception if an organization could not be found.
     */
    private function getOrganizationId(array $samlAttributes, int $personId): int
    {
        if ($personId !== -1) {
            return Organizations::getOrganizationIdForPerson($personId);
        } elseif (!empty($samlAttributes['organization'])) {
            return Organizations::getIdByName($samlAttributes['organization'][0]);
        }
        return -1;
    }

    /**
     * Determines if we should send an email notification to the admin about a newly created user that may need further
     * attention to be fully setup.
     *
     * @param XDUser $user the newly created user.
     * @param array $samlAttributes the newly created userse SAML attributes.
     * @return void
     * @throws Exception
     */
    private function handleNotifications(XDUser $user, array $samlAttributes): void
    {
        if ($user->getOrganizationID() !== -1) {
            // Only send email if we were unable to identify an organization for the user.
            return;
        }

        $linked = $user->getPersonID() !== UNKNOWN_USER_TYPE;

        $subject = sprintf(
            'New %s Single Sign On User Created',
            ($linked ? 'Linked' : 'Unlinked')
        );

        $body = sprintf(
            self::BASE_ADMIN_EMAIL,
            $user->getFormalName(true),
            $user->getUsername(),
            $user->getEmailAddress(),
            json_encode($samlAttributes, JSON_PRETTY_PRINT)
        );

        try {
            $this->notificationMailer->send(
                array(
                    'subject' => $subject,
                    'body' => $body,
                    'toAddress' => $this->portalSettings->getConfigurationOption('general', 'tech_support_recipient')
                )
            );
        } catch (Exception $e) {
            // log the exception so we have some persistent visibility into the problem.
            $errorMsgFormat = "[%s] %s\n%s";
            $errorMsg = sprintf(
                $errorMsgFormat,
                $e->getCode(),
                $e->getMessage(),
                $e->getTraceAsString()
            );

            $this->logger->error("Error encountered while emailing\n$errorMsg");

            throw $e;
        }
    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): ?Response
    {
        $this->logger->info('SimpleSAMLPHP Authentication Succeeded!');
        return null;
    }

    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): ?Response
    {
        $this->logger->info('SimpleSAMLPHP Authentication Failed!', [$exception]);
        return null;
    }

    public function start(Request $request, ?AuthenticationException $authException = null): Response
    {
        return new RedirectResponse($this->urlGenerator->generate('xdmod_home'));
    }
}
