<?php

namespace CCR\Security\Attributes;

use CCR\Security\Listeners\MgrRequiredAttributeListener;
use Symfony\Component\ExpressionLanguage\Expression;

/**
 * This attribute, when used to decorate a Symfony Controller class or Route function, restricts which users are
 * authorized to request the Controller or Route to those with the Manager Acl ( those who have access to the Internal
 * Dashboard. ).
 *
 * By pairing this Attribute with an accompanying AttributeListener ( @see MgrRequiredAttributeListener ) class attached
 * to the Kernel Controller Event, we are able to provide the "Restrict this route to users w/ the specified ACL".
 *
 * Note: the implementation of this Attribute and the MgrRequiredAttributeListener was directly copied from the
 * Symfony `IsGranted` Attribute and the associated `IsGrantedAttributeListener`.
 */
#[\Attribute(\Attribute::IS_REPEATABLE | \Attribute::TARGET_CLASS | \Attribute::TARGET_METHOD | \Attribute::TARGET_FUNCTION)]
class MgrRequired
{
    /**
     * This is the expression that ensures that a user that requests an endpoint decorated with this attribute *must*
     * have the "mgr" acl, else an AccessDeniedHttpException will be thrown ( @see MgrRequiredAttributeListener ).
     *
     * @var string
     */
    const EXPRESSION = '"mgr" in role_names';

    public function __construct(
        /**
         * Sets the first argument that will be passed to isGranted().
         */
        public string|Expression            $attribute = new Expression(self::EXPRESSION),
        /**
         * Sets the second argument passed to isGranted().
         *
         * @var array<string|Expression>|string|Expression|null
         */
        public array|string|Expression|null $subject = null,
        /**
         * The message of the exception - has a nice default if not set.
         */
        public ?string                      $message = null,
        /**
         * If set, will throw HttpKernel's HttpException with the given $statusCode.
         * If null, Security\Core's AccessDeniedException will be used.
         */
        public ?int                         $statusCode = null,
        /**
         * If set, will add the exception code to thrown exception.
         */
        public ?int                         $exceptionCode = null,
    ) {
    }
}
