<?php declare(strict_types=1);

namespace CCR\EnvVar;

use CCR\Configuration\IniConfiguration;
use Symfony\Component\DependencyInjection\EnvVarLoaderInterface;

class ReCaptchaEnvVarLoader implements EnvVarLoaderInterface
{

    public function __construct(
        private readonly IniConfiguration $portalSettings
    ) {

    }

    public function loadEnvVars(): array
    {
        try {
            $siteKey = $this->portalSettings->getConfigurationOption('mailer', 'captcha_public_key');
            $privateKey = $this->portalSettings->getConfigurationOption('mailer', 'captcha_private_key');
        } catch (\Exception $e) {
            throw new \RuntimeException('Missing Google ReCaptcha settings in portal_settings.ini', 0, $e);
        }

        return [
            'GOOGLE_RECAPTCHA_SITE_KEY' => $siteKey,
            'GOOGLE_RECAPTCHA_SECRET' => $privateKey
        ];
    }
}
