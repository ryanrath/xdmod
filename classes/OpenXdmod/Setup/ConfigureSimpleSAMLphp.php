<?php

namespace OpenXdmod\Setup;

class ConfigureSimpleSAMLphp extends SetupItem
{

    /**
     * @var SSOSetup
     */
    protected $parent;

    /**
     * @var array
     */
    protected $config = array();

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
            'base_url_path' => 'simplesaml/',
            'cert_dir' => '/etc/xdmod/simplesamlphp/cert',
            'cert_file_name' => 'xdmod-idp-cert.crt',
            'private_key_name' => 'xdmod-idp-private.pem',
            'metadata_dir' => '/etc/xdmod/simplesamlphp/metadata',
            'tmp_dir' => '/tmp/simplesaml',
            'log_dir' => '/var/log/simplesaml',
            'data_dir' => 'data/',
            'secret_salt' => hash('sha256', date('%r') . rand())
        );
    }

    public function handle()
    {
        $publicUrl = null;
        $settings = $this->loadIniConfig('portal_settings');
        if (array_key_exists('general', $settings) && array_key_exists('site_address', $settings['general'])) {
            $publicUrl = $settings['general']['site_address'];
        }
        $this->console->displaySectionHeader('Configure SimplSAMLphp (Simple)');
        $this->console->displayMessage(<<<TXT
The following process will guide you through the simplified setup of SimpleSAMLphp. What this means is that you will be
asked for the bear minimum information needed to configure XDMoD to use an Identity Provider during the authentication
process.

After you have completed this section, please select '3 - Configure Identity Provider' to complete the configuration.

The following configuration values are used for and can be found in /etc/xdmod/simplesamlphp/config/config.php

TXT
        );

        $config['public_url'] = $this->console->prompt('What is the public URL for this XDMoD Instance?', $publicUrl);
        $this->console->displayBlankLine();
        $this->console->displayMessage('This password secures SimpleSAMLphps\'s admin interface.');
        $config['admin_password'] = $this->console->silentPrompt('Admin Password');
        $this->console->displayBlankLine();

        $config = array_merge($config, $this->defaults);
        $this->parent->setConfig($config);
        $this->console->displayMessage('Done!');
    }
}
