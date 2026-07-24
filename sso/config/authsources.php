<?php
$config = array(
    'xdmod-sp' => array(
        'saml:SP',
        'host' => 'https://localhost:8181',
        'entityID' => 'https://localhost:8181/xdmod-sp',
        'idp' => 'xdmod-hosted-idp-oidc/oauth2',
        'authproc' => array(
            10 => array(
                'class' => 'core:AttributeMap',
                'email' => 'email_address',
                'preferred_username' => 'username',
                'given_name' => 'first_name',
                'family_name' => 'last_name',
                'organization' => 'organization'
            ),
            // Ensures that the 'username' property has one or more non-whitespace characters
            60 => array(
                'class' => 'authorize:Authorize',
                'username' => array(
                    '/\S+/'
                ),
            ),
            // Ensures that the 'organization' property has one or more non-whitespace characters
            61 => array(
                'class' => 'authorize:Authorize',
                'organization' => array(
                    '/\S+/'
                )
            )
        )
    ),
    'oidc-xdmod' => array(
        'authoidcoauth2:OIDCOAuth2',
        'entityID' => 'https://localhost:8181/xdmod-oidc',
        'auth_endpoint' => 'http://localhost:8080/realms/xdmod/protocol/openid-connect',
        'auth_path' => '/auth',
        'api_endpoint' => 'http://localhost:8080/realms/xdmod/protocol/openid-connectt',
        'token_path' => '/token',
        'user_info_path' => './userinfo',
        'key' => 'xdmod-oidc',
        'client_id' => 'xdmod-oidc',
        'client_secret' => 'ewRraHxwpYEyWLhxaey9WErJEx19hPip',
        'secret' => 'ewRraHxwpYEyWLhxaey9WErJEx19hPip',
        'scope' => 'openid email profile',
        'response_type' => 'code',
        'use_header_for_auth' => false,
        'redirect_uri' => 'https://localhost:8181/simplesaml/module.php/authoidcoauth2/linkback.php',
        'verify_ssl' => 0
    ),

    'admin' => array(
        // The default is to use core:AdminPassword, but it can be replaced with
        // any authentication source.
        'core:AdminPassword',
    )
);
