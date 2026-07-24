<?php
$metadata['xdmod-hosted-idp-oidc/oauth2'] = array (
    'metadata-set' => 'saml20-idp-hosted',
    'entityID' => 'https://localhost:8181/xdmod-remote-idp-oidc/oauth2',
    'SingleSignOnService' => array (
        0 =>
            array (
                'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect',
                'Location' => 'https://localhost:8181/simplesaml/saml2/idp/SSOService.php',
            ),
    ),
    'SingleLogoutService' => array (
        0 =>
            array (
                'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect',
                'Location' => 'https://localhost:8181/simplesaml/saml2/idp/SingleLogoutService.php',
            ),
    ),
    'certFile' => 'xdmod-simplesaml-cert.crt',
    'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient',
    'contacts' => array (
        0 =>
            array (
                'emailAddress' => '[:tech_contact_email:]',
                'contactType' => 'technical',
                'givenName' => '[:tech_contact_name:]',
            ),
    ),
    'icon' => '[:icon_base64_data:]'
);
