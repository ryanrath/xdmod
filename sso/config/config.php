<?php
$config = array(
    'baseurlpath' => 'simplesaml/',
    'certdir' => '/etc/xdmod/simplesamlphp/cert',
    'loggingdir' => '/var/log/xdmod',
    'datadir' => 'data/',
    'tempdir' => '/tmp/simplesamlphp',
    'debug' => false,

    'showerrors' => false,
    'errorreporting' => false,

    'debug.validatexml' => false,

    'auth.adminpassword' => 'test123',
    'admin.protectindexpage' => true,
    'admin.protectmetadata' => true,

    'secretsalt' => 'deca85a9a5243ca516b9c2984b33f164236e2b6ec3209c52a399cdc199c0acc1',

    'technicalcontact_name' => '[:technical_contact_name:]',
    'technicalcontact_email' => '[:technical_contact_email:]',

    'timezone' => null,

    'logging.level' => SimpleSAML_Logger::INFO,
    'logging.handler' => 'syslog',

    'logging.facility' => defined('LOG_LOCAL5') ? constant('LOG_LOCAL5') : LOG_USER,

    'logging.processname' => 'simplesamlphp',
    'logging.logfile' => 'simplesamlphp.log',
    'statistics.out' => array(),


    'enable.saml20-idp' => true,
    'enable.shib13-idp' => false,
    'enable.adfs-idp' => false,
    'enable.wsfed-sp' => false,
    'enable.authmemcookie' => false,

    'session.duration' => 8 * (60 * 60), // 8 hours.
    'session.datastore.timeout' => (4 * 60 * 60), // 4 hours
    'session.state.timeout' => (60 * 60), // 1 hour
    'session.cookie.name' => 'SimpleSAMLSessionID',
    'session.cookie.lifetime' => 0,
    'session.cookie.path' => '/',
    'session.cookie.domain' => null,
    'session.cookie.secure' => false,
    'session.disable_fallback' => false,
    'enable.http_post' => false,
    'session.phpsession.cookiename' => 'SimpleSAMLPHPCookie',
    'session.phpsession.savepath' => null,
    'session.phpsession.httponly' => false,
    'session.authtoken.cookiename' => 'SimpleSAMLAuthToken',
    'session.rememberme.enable' => false,
    'session.rememberme.checked' => false,
    'session.rememberme.lifetime' => (14 * 86400),

    'language.available' => array('en'),
    'language.default' => 'en',
    'language.parameter.name' => 'language',
    'language.parameter.setcookie' => true,
    'language.cookie.name' => 'language',
    'language.cookie.domain' => null,
    'language.cookie.path' => '/',
    'language.cookie.lifetime' => (60 * 60 * 24 * 900),

    'attributes.extradictionary' => null,

    'theme.use' => 'default',

    'default-wsfed-idp' => 'urn:federation:pingfederate:localhost',

    'idpdisco.enableremember' => true,
    'idpdisco.rememberchecked' => true,
    'idpdisco.validate' => true,
    'idpdisco.extDiscoveryStorage' => null,
    'idpdisco.layout' => 'dropdown',
    'shib13.signresponse' => true,

    'authproc.idp' => array(),
    'authproc.sp' => array(
        10 => array(
            'class' => 'core:AttributeMap',
            'email' => 'email_address',
        ),

        // Adopts language from attribute to use in UI
        90 => 'core:LanguageAdaptor',
    ),

    'metadata.sources' => array(
        array(
            'type' => 'flatfile',
            'directory' => '/etc/xdmod/simplesamlphp/metadata/'
        ),
    ),
    'store.type' => 'phpsession',

    'store.sql.dsn' => 'sqlite:/path/to/sqlitedatabase.sq3',
    'store.sql.username' => null,
    'store.sql.password' => null,
    'store.sql.prefix' => 'simpleSAMLphp',

    'memcache_store.servers' => array(
        array(
            array('hostname' => 'localhost'),
        ),
    ),
    'memcache_store.expires' => 36 * (60 * 60), // 36 hours.
    'metadata.sign.enable' => false,
    'metadata.sign.privatekey' => null,
    'metadata.sign.privatekey_pass' => null,
    'metadata.sign.certificate' => null,

    'proxy' => null,

    'trusted.url.domains' => array('https://localhost:8181'),
);
