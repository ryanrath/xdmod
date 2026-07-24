<?php

namespace OpenXdmod\Setup;

use OpenXdmod\Validation\Exceptions\ValidationException;
use Xdmod\Template;

class SSOSetup extends SubMenuSetupItem
{

    /**
     * @var Menu
     */
    protected $menu;

    protected $simplesamlConfig;

    protected $identityProviderConfig;

    protected $quit = false;

    protected $defaultConfigDir = null;

    protected $defaultMetadataDir = null;

    protected $defaultCertDir = null;

    protected $defaultCertName = 'xdmod-simplesaml-cert.crt';

    protected $defaultPrivateKeyName = 'xdmod-simplesaml-private-key.pem';

    protected $defaultPublicKeyName = 'xdmod-simplesaml-public-key.pem';

    protected $defaultLogingDir = '/var/log/xdmod';

    protected $defaultTempDir = '/tmp/simplesamlphp';

    protected $files = array();

    protected $idpTypeToTemplate = [
        'oidc/oauth2' => 'oidc-idp-fragment',
        'ldap' => 'ldap-idp-fragment'
    ];

    public function __construct(Console $console)
    {
        parent::__construct($console);

        $simpleSamlBaseDir = implode(DIRECTORY_SEPARATOR, array(CONFIG_DIR, 'simplesamlphp'));
        $this->defaultConfigDir = implode(DIRECTORY_SEPARATOR, array($simpleSamlBaseDir, 'config'));
        $this->defaultMetadataDir = implode(DIRECTORY_SEPARATOR, array($simpleSamlBaseDir, 'metadata'));
        $this->defaultCertDir = implode(DIRECTORY_SEPARATOR, array($simpleSamlBaseDir, 'cert'));

        $menuItems = array(
            new MenuItem(
                '1',
                'Configure SimpleSAMLphp',
                new ConfigureSimpleSAMLphp($this->console, $this)
            ),
            new MenuItem(
                '2',
                'Configure Identity Provider',
                new ConfigureSSOIdentityProvider($this->console, $this)
            ),
            new MenuItem(
                '3',
                'Validate SSO Settings',
                new ValidateSSOSettings($this->console, $this)
            ),
            new MenuItem(
                's',
                'Save (and return to main menu)',
                new SubMenuSaveSetup($this->console, $this)
            ),
            new MenuItem(
                'q',
                'Quit (and return to main menu)',
                new SubMenuQuitSetup($this->console, $this)
            )
        );

        $this->menu = new Menu($menuItems, $this->console, 'SSO Setup');
    }


    public function handle()
    {
        $this->quit = false;

        while (!$this->quit) {
            $this->menu->display();
        }
    }

    public function save()
    {
        if (empty($this->simplesamlConfig)) {
            $this->console->displayWarning('You must finish the "Configure SimpleSAMLphp" section before saving.');
        }

        if (empty($this->identityProviderConfig)) {
            $this->console->displayWarning('You must finish the "Configure Identity Provider" section before saving.');
        }

        $this->console->displayBlankLine();

        # create the simplesamlphp
        mkdir($this->defaultConfigDir, 0777, true);
        mkdir($this->defaultMetadataDir, 0777, true);
        mkdir($this->defaultCertDir, 0777, true);

        $config = array_merge($this->simplesamlConfig, $this->identityProviderConfig);
        $config['cert-name'] = $this->defaultCertName;
        $config['priv-key-name']= $this->defaultPrivateKeyName;
        $config['pub-key-name'] = $this->defaultPublicKeyName;
        $config['logging_dir'] = $this->defaultLogingDir;
        $config['temp_dir'] = $this->defaultTempDir;
        $config['oidc-idp-name'] = 'xdmod';
        $config['idp-id'] = sprintf('oidc-%s', $config['oidc-idp-name']);
        $config['sp_id'] = 'xdmod-sp';
        $config['sp_entity_id'] = sprintf('%s/%s', $config['public_url'], $config['sp_id']);

        $this->createKeysAndCerts($config);
        $this->createConfigFile($config);
        $this->createAuthSources($config);
        $this->createMetadata($config);

        try {
            $this->validateSSOConfigs();
        } catch (\Exception $e) {
            $this->console->clear();
            $this->console->displaySectionHeader('Error validating SSO config files');
            $this->console->displayWarning($e->getMessage());
        }
    }

    public function quit()
    {
        $this->quit = true;
    }

    public function getConfig()
    {
        return $this->simplesamlConfig;
    }

    public function setConfig(array $config)
    {
        $this->simplesamlConfig = $config;
    }

    public function setIdentityProviderConfig(array $config)
    {
        $this->identityProviderConfig = $config;
    }

    public function createKeysAndCerts($config)
    {
        // xdmod-simplesaml-cert.crt
        $certName = $config['cert-name'];
        // xdmod-simplesaml-private-key.pem
        $privKeyName = $config['priv-key-name'];
        //xdmod-simplesaml-public-key.pem
        $pubKeyName = $config['pub-key-name'];

        $createCertPrivKey = <<<CMD
pushd {$this->defaultCertDir} && \
  openssl req -newkey rsa:3072 -new -x509 -days 3652 -nodes -out {$certName}  -keyout {$privKeyName} --subj '/C=US/ST=New York/L=Buffalo/O=UB/CN=XDMoD Default Identity Provider' && \
popd
CMD;
        $createPubKey = <<<CMD
pushd {$this->defaultCertDir} && \
  openssl rsa -in {$privKeyName} -pubout > {$pubKeyName} &&
popd
CMD;

        $this->executeCommand($createCertPrivKey);
        $this->executeCommand($createPubKey);
    }

    public function createConfigFile(array $config)
    {
        $this->files['config'] = implode(DIRECTORY_SEPARATOR, array($this->defaultConfigDir, 'config.php'));

        $configTemplate = new Template('config', 'sso');
        $configTemplate->apply($config);
        $configTemplate->saveTo($this->files['config']);
    }

    public function createAuthSources(array $config)
    {
        $this->files['authsources'] = implode(DIRECTORY_SEPARATOR, array($this->defaultConfigDir, 'authsources.php'));
        $idpType = $config['idp_type'];
        $fragmentName = $this->idpTypeToTemplate[$config['idp_type']];
        echo var_export($this->idpTypeToTemplate, true) . "\n";
        echo var_export($idpType, true) . "\n";
        echo var_export($fragmentName, true) . "\n";
        # generate the idp content fragment, and save it for use in authsources

        $idpFragment = new Template($fragmentName, 'sso');
        $idpFragment->apply($config);
        $config['idp-fragment'] = $idpFragment->getContents();

        $authSourcesTemplate = new Template('authsources', 'sso');
        $authSourcesTemplate->apply($config);
        $authSourcesTemplate->saveTo($this->files['authsources']);
    }

    /**
     * @param array $config
     * @return void
     * @throws \Exception if there is a problem saving any of the metadata files.
     */
    public function createMetadata(array $config)
    {
        $this->files['saml20-idp-hosted'] = implode(DIRECTORY_SEPARATOR, array($this->defaultMetadataDir, 'saml20-idp-hosted.php'));
        $this->files['saml20-idp-remote'] = implode(DIRECTORY_SEPARATOR, array($this->defaultMetadataDir, 'saml20-idp-remote.php'));
        $this->files['saml20-sp-remote'] = implode(DIRECTORY_SEPARATOR, array($this->defaultMetadataDir, 'saml20-sp-remote.php'));

        $idpHostedTemplate = new Template('saml20-idp-hosted', 'sso');
        $idpRemoteTemplate = new Template('saml20-idp-remote', 'sso');
        $spRemoteTemplate = new Template('saml20-sp-remote', 'sso');

        $idpHostedTemplate->apply($config);
        $idpRemoteTemplate->apply($config);
        $spRemoteTemplate->apply($config);

        $idpHostedTemplate->saveTo($this->files['saml20-idp-hosted']);
        $idpRemoteTemplate->saveTo($this->files['saml20-idp-remote']);
        $spRemoteTemplate->saveTo($this->files['saml20-sp-remote']);

    }

    /**
     * @throws \Exception
     */
    public function validateSSOConfigs()
    {
        foreach ($this->files as $fileName => $filePath) {
            $this->checkPHPSyntax($filePath);
        }
    }

    public function checkPHPSyntax(string $filePath)
    {
        $this->executeCommand(sprintf('php -l %s', $filePath));
    }


}
