<?php

namespace OpenXdmod\Setup;

use function xd_utilities\string_ends_with;

class ConfigureSSOIdentityProvider extends SetupItem
{

    const IDP_OIDC_OAUTH2 = 'oidc/oauth2';
    const IDP_LDAP = 'ldap';

    const LDAP_SEARCH_USERNAME = 'Search Username/Password';
    const LDAP_DN_PATTERN = 'DN Pattern';

    /**
     * @var SSOSetup
     */
    protected $parent;

    protected $defaults;

    /**
     * @param Console $console
     * @param SSOSetup $parent
     */
    public function __construct(Console $console, SSOSetup $parent)
    {
        parent::__construct($console);
        $this->parent = $parent;


        $this->defaults = array(
            'sp_id' => 'xdmod-sp',
            'idp_entity_id' => 'xdmod-hosted-idp',
            'use_header_for_auth' => false,
            'verify_ssl' => 0
        );

    }

    public function handle()
    {
        $this->console->clear();
        $this->console->displaySectionHeader(<<<TXT
This process will guide you through the selection and configuration of the identity provider you would like XDMoD to use
for authentication. At this point in time we support two authentication protocols, OpenIDC/OAuth2 and LDAP, so as long as your identity provider
can utilize one of these protocols then they can be used by XDMoD for authentication purposes.

The following configuration values are used for and can be found in the following files:
  - /etc/xdmod/simplesamlphp/config/authsources.php
  - /etc/xdmod/simplesamlphp/metadata/saml20-idp-hosted.php
  - /etc/xdmod/simplesamlphp/metadata/saml20-idp-remote.php
  - /etc/xdmod/simplesamlphp/metadata/saml20-sp-remote.php

TXT
        );
        $config['idp_type'] = $this->console->prompt('What type of IDP is being used?', self::IDP_OIDC_OAUTH2, array(self::IDP_OIDC_OAUTH2, self::IDP_LDAP));
        switch ($config['idp_type']) {
            case self::IDP_OIDC_OAUTH2:
                $idpEndpoint = $this->console->prompt('Identity Provider URL:');

                # remove any trailing slashes.
                if (string_ends_with($idpEndpoint, '/')) {
                    $idpEndpoint = substr($idpEndpoint,0, strlen($idpEndpoint) - 2);
                }

                $config['auth_endpoint'] = $idpEndpoint;
                $config['auth_path'] = '/auth';
                $config['api_endpoint'] = $idpEndpoint;
                $config['token_path'] = '/token';
                $config['user_info_path'] = '/userinfo';
                $config['idp_client_id'] = $this->console->prompt('Client ID:', 'xdmod-oidc');
                $config['idp_client_secret'] = $this->console->silentPrompt('Client Secret');
                $config['idp_client_scope'] = $this->console->prompt('Client Scope:', 'openid email profile');
                $config['idp_response_type'] = 'code';
                break;
            case self::IDP_LDAP:
                $config['hostname'] = $this->console->prompt('Host of LDAP Server?');
                $config['port'] = $this->console->prompt('LDAP Port?', '389');
                $config['enable_tls'] = $this->console->promptBool('Does this server require TLS?');
                $this->console->displayBlankLine();
                $searchType = $this->console->prompt('Does your LDAP server require a Search Username / Password or DN Pattern to search for users?', self::LDAP_SEARCH_USERNAME, [self::LDAP_SEARCH_USERNAME, self::LDAP_DN_PATTERN]);
                $this->console->displayBlankLine();
                if ($searchType === self::LDAP_SEARCH_USERNAME) {
                    $config['search_username'] = $this->console->prompt('LDAP Search Username');
                    $config['search_password'] = $this->console->silentPrompt('LDAP Search Password');
                } elseif ($searchType === self::LDAP_DN_PATTERN) {
                    $config['dnpattern'] = $this->console->prompt('What is the DN Pattern for users?', '');
                } else {
                    $this->console->displayWarning('Unrecognized entry, unable to continue.');
                }

                break;
            default:
                $this->console->displayWarning('Unrecognized IDP type, unable to continue');
                break;
        }

        $this->parent->setIdentityProviderConfig($config);
    }
}
