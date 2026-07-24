<?php
$config = array(
    'access-sp' => array(
        'saml:SP',
        'host'     => 'xdmod-dev.ccr.xdmod.org',
        'entityID' => 'https://xdmod-dev.ccr.xdmod.org/simpleSAMLphp-xdmod-ccr',
        'idp'      => 'xdmod-hosted-idp-ccr-oidc',
        'authproc' => array(
            10 => array(
                'class'       => 'core:AttributeMap',
                'email'       => 'email_address',
                'given_name'  => 'first_name',
                'family_name' => 'last_name',
            ),

            20 => array(
                'class' => 'core:PHP',
                'code'  => '
					if (array_key_exists("eppn", $attributes)) {
	        				$eppn = $attributes["eppn"][0];
					        if (strpos($eppn, "@") === false) {
							$attributes["username"][0] = $eppn;
				        	} else {
					            $parts = explode("@", $eppn);
					            $attributes["username"][0] = $parts[0];
						}
					}
					if (array_key_exists("idp_name", $attributes)) {
						$idpName = $attributes["idp_name"][0];
						if ($idpName === "ACCESS") {
							$attributes["organization"][0] = "TG";
						}
					}
				'
            ),

            // Ensures that the 'username' property has one or more non-whitespace characters
            60 => array(
                'class'    => 'authorize:Authorize',
                'username' => array(
                    '/\S+/'
                ),
            ),

            // Ensure that the 'organization' property has one or more non-whitespace characters
            70 => array(
                'class'        => 'authorize:Authorize',
                'organization' => array(
                    '/\S+/'
                )
            )
        )
    ),
    'ccr-oidc'  => array(
        'authoidcoauth2:OIDCOAuth2',
        'entityID'            => 'https://xdmod-dev.ccr.xdmod.org/simpleSAMLphp-xdmod-ccr-oidc',
        'auth_endpoint'       => 'https://cilogon.org',
        'auth_path'           => '/authorize',
        'api_endpoint'        => 'https://cilogon.org',
        'token_path'          => '/oauth2/token',
        'user_info_path'      => '/oauth2/userinfo',
        'key'                 => 'cilogon:/client_id/77ce01025802bfc6f295f17dbb6213da',
        'client_id'           => 'cilogon:/client_id/77ce01025802bfc6f295f17dbb6213da',
        'client_secret'       => 'c_FU5Ve5gBDew4CNol2owZscVtgJHOWiYXKZyo7qIjDNYTbkrs4g6Zf7sFkEXs4HImtcoqyeGucsqrWuFh0xbA',
        'secret'              => 'c_FU5Ve5gBDew4CNol2owZscVtgJHOWiYXKZyo7qIjDNYTbkrs4g6Zf7sFkEXs4HImtcoqyeGucsqrWuFh0xbA',
        'scope'               => 'email openid org.cilogon.userinfo profile',
        'response_type'       => 'code',
        'use_header_for_auth' => false,
        'redirect_uri'        => 'https://xdmod-dev.ccr.xdmod.org/simplesaml/module.php/authoidcoauth2/linkback.php',
        'verify_ssl'          => 0
    ),
    'admin'     => array(
        // The default is to use core:AdminPassword, but it can be replaced with
        // any authentication source.
        'core:AdminPassword',
    )

);
