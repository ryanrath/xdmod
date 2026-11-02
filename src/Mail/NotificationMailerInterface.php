<?php

namespace CCR\Mail;

/**
 * Implementors of this interface are eligible to be used by SimpleSamlAuthenticator to send out notifications. The
 * default implementation of this interface is NotificationMailer, which uses our MailWrapper class under the hood to
 * send emails. Wiring of which implementor of is used at what time is constrolled by Symfony's auto-wiring / dependency
 * injection system. See https://symfony.com/doc/current/service_container.html for more information.
 */
interface NotificationMailerInterface
{
    /** Send a message using the property format accepted by CCR\MailWrapper. */
    public function send(array $properties): void;
}
