<?php

namespace CCR\Mail;

use CCR\MailWrapper;

/** Preserve the existing PHPMailer/sendmail transport for notification delivery. */

/**
 * A concrete implementation of the NotificationMailerInterface that uses our MailWrapper class to send notifications.
 */
class NotificationMailer implements NotificationMailerInterface
{
    /**
     * Send a notification using the MailWrapper class.
     *
     * @param array $properties that will be used to configure both PHPMailler and costruct the email that is sent.
     *
     * @return void
     * @throws \Exception
     */
    public function send(array $properties): void
    {
        MailWrapper::sendMail($properties);
    }
}
