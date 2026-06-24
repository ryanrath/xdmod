<?php

declare(strict_types=1);

namespace CCR\DependencyInjection\Configuration;

use CCR\Security\SamlAuthenticationSuccessHandler;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\HttpKernel\DependencyInjection\ConfigurableExtension;

/**
 *
 */
class NbgrpOneloginSamlExtension extends ConfigurableExtension
{

    /**
     * @inheritDoc
     */
    protected function loadInternal(array $mergedConfig, ContainerBuilder $container): void
    {
        $definition = $container->getDefinition(\Nbgrp\OneloginSamlBundle\Security\Http\Authenticator\SamlAuthenticator::class);
        $definition->replaceArgument(4, SamlAuthenticationSuccessHandler::class);
    }
}
