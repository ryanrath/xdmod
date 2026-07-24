<?php
/*
 * since this is pulled from the IDP and expires, it should be done as part of a cronjob
 */
/*
 * since this is pulled from the IDP and expires, it should be done as part of a cronjob
 */
$metadata['xdmod-hosted-idp-ccr-oidc'] = array(
    /*
     * The hostname for this IdP. This makes it possible to run multiple
     * IdPs from the same configuration. '__DEFAULT__' means that this one
     * should be used by default.
     */
    'host' => '__DEFAULT__',

    /*
     * The private key to use when signing responses.
     * These are stored in the cert-directory.
     */
    'privatekey'  => 'xdmod-idp.pem',

    /*
     * The authentication source which should be used to authenticate the
     * user. This must match one of the entries in config/authsources.php.
     */
    'auth' => 'ccr-oidc',
);