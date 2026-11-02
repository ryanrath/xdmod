<?php

namespace IntegrationTests\Security\Authenticators;

use CCR\Configuration\IniConfiguration;
use CCR\Kernel;
use CCR\Mail\NotificationMailerInterface;
use CCR\MailWrapper;
use PHPMailer\PHPMailer\Exception as MailerException;
use PHPMailer\PHPMailer\PHPMailer;
use CCR\Security\Authenticators\SimpleSamlPhpAuthenticator;
use Exception;
use Monolog\Handler\TestHandler;
use Monolog\Logger;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;
use Symfony\Component\DependencyInjection\Compiler\CompilerPassInterface;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\DependencyInjection\Reference;
use Symfony\Component\Filesystem\Filesystem;
use XDUser;

/**
 * This class specifically exercises and tests our new user notification composition, configuration, and delivery
 * through a real Symfony service container. It uses Reflection to directly invoke the function so as to avoid
 * requiring an identity provider or writing users to the database.
 *
 * The general classes of behavior we're testing for here are:
 *   - Notification composition and delivery ( via SimpleSamlPhpAuthenticator::handleNotifications and
 *     $notificationMailer)
 *   - Configuration of notification settings ( via per test, folder / file setup in temporary directory ) including
 *     things like what happens when we're in debug_mode.
 *   - Handling of notification failures ( via our RecordingNotificationMailer which stands in for the class we use in
 *     non-test instances, NotificationMailer.php )
 *   - Validation of recipient addresses. ( again via our RecordingNotificationMailer, this time using the PHPMailer
 *     instance returned by our MailWrapper's `initPHPMailer` method.)
 *
 * NOTE: These tests only cover `SimpleSamlPhpAuthenticator::handleNotifications` they do not cover the whole
 * authenticate()/saveUser() call sequence.
 *
 * The basic execution for each test is:
 *   - `setUp` is called, which creates a temporary directory, initializes a custom Symfony test kernel, and pulls
 *     refernces to the services configured by said kernel for use by the test.
 *   - The test set's up the conditions to be tested ( creating users with specific attributes, setting up the mailer
 *     to simulate a delivery failure etc. )
 *   - The test executes `notify` and checks that whatever was expected occurs.
 *   - `tearDown` is called, which cleans up everything in the temporary directory.
 */
class SimpleSamlPhpNotificationTest extends TestCase
{
    /**
     * The directory used to store temporary files.
     */
    private string $directory;

    /**
     * The custom kernel we will be using to exercise SSO notifications.
     */
    private NotificationTestKernel $kernel;

    /**
     * The authenticator instance used to invoke `handleNotifications`.
     */
    private SimpleSamlPhpAuthenticator $authenticator;

    /**
     * A simple implementation of the `NotificationMailer` interface that we'll use to record the messages we send.
     */
    private RecordingNotificationMailer $mailer;

    /**
     * A simple implementation of the `LoggerInterface`, provided by Monolog that we'll use to record the logs we
     * generate.
     */
    private TestHandler $logs;

    // Information we use to generate the test user.
    private string $testUserFormalName = 'Taylor Example';
    private string $testUserUserName = 'notification-test-user';
    private string $testUserEmailAddress = 'taylor@example.org';

    /**
     * Each test will have available to it:
     *   - A temporary directory that contains a bare bones portal_settings file, portal_settings.d directory, and a
     *     support.ini file ( to ensure that we can support / pickup changes in ini overrides )
     *   - A newly instantiated / configured test Kernel (NotificationTestKernel)
     *   - An instance of RecordingNotificationMailer, retrieved from the test kernel.
     *   - An instance of TestHandler (test.notification_logs), that will track things like test failures etc.
     *     retrieved from the test kernel.
     *   - An instance of SimpleSamlPhpAuthenticator, retrieved from the test kernel. This will be used to invoke the
     *     `handleNotification` function.
     * @return void
     * @throws \Random\RandomException if a suitable source of randomness cannot be found to generate the unique
     * temporary directory name.
     */
    protected function setUp(): void
    {
        // Setup the temporary directory that a test and it's fixtures will use.
        $this->directory = sys_get_temp_dir() . '/xdmod-sso-notification-' . bin2hex(random_bytes(8));
        mkdir($this->directory, 0700);
        mkdir($this->directory . '/portal_settings.d', 0700);

        // Create a bare bones portal_settings file w/ just the values the tests will need to operate.
        file_put_contents($this->directory . '/portal_settings.ini',
                          "[general]\ntech_support_recipient = base-support@example.org\n");
        // The recipient must come from the merged settings, including overrides.
        file_put_contents($this->directory . '/portal_settings.d/support.ini',
                          "[general]\ntech_support_recipient = sso-support@example.org\n");

        // Setup our Test Kernel and it's dependencies for the tests to use.
        $this->kernel = new NotificationTestKernel($this->directory);
        $this->kernel->boot();
        $container = $this->kernel->getContainer();
        $this->mailer = $container->get(RecordingNotificationMailer::class);
        $this->logs = $container->get('test.notification_logs');
        $this->authenticator = $container->get(SimpleSamlPhpAuthenticator::class);
    }

    /**
     * Make sure to shutdown the kernel if it exists, and to remove the temporary directory.
     *
     * @return void
     */
    protected function tearDown(): void
    {
        try {
            if (isset($this->kernel)) {
                $this->kernel->shutdown();
            }
        } finally {
            if (isset($this->directory)) {
                (new Filesystem())->remove($this->directory);
            }
        }
    }

    /**
     * Helper function that creates a mock instance of XDUser that will supply only the information needed for these
     * tests. This allows us to avoid database writes, and ensures that the tests are not affected by changes to the
     * database.
     *
     * @param int $organizationId the organization id the generated user will be associated with.
     * @param int $personId       the person id the generated user will be associated with.
     *
     * @return XDUser a mock XDUser instance.
     */
    private function user(int $organizationId, int $personId): XDUser
    {
        $user = $this->getMockBuilder(XDUser::class)
            ->disableOriginalConstructor()
            ->onlyMethods(['getOrganizationID', 'getPersonID', 'getFormalName', 'getUsername', 'getEmailAddress'])
            ->getMock();
        $user->method('getOrganizationID')->willReturn($organizationId);
        $user->method('getPersonID')->willReturn($personId);
        $user->method('getFormalName')->with(true)->willReturn($this->testUserFormalName);
        $user->method('getUsername')->willReturn($this->testUserUserName);
        $user->method('getEmailAddress')->willReturn($this->testUserEmailAddress);
        return $user;
    }

    /**
     * Helper method that utilizes reflection to invoke the handleNotifications method on the
     * SimpleSamlPhpAuthenticator class with the provided $user and $attributes.
     *
     * @param XDUser $user
     * @param array  $attributes
     *
     * @return void
     * @throws \ReflectionException if the SimpleSamlPhpAuthenticator class does not exist or if it does not have
     * a handleNotifications method.
     */
    private function notify(XDUser $user, array $attributes): void
    {
        $method = new ReflectionMethod(SimpleSamlPhpAuthenticator::class, 'handleNotifications');
        $method->setAccessible(true);
        $method->invoke($this->authenticator, $user, $attributes);
    }

    /**
     * This is the happy path test, here we're verifying that users that we are unable to find a known organization for
     * generate exactly one message with the correct linked status, merged recipient, personal data, and SAML attributes.
     *
     * @dataProvider providePersonLinks
     */
    public function testUnknownOrganizationSendsNotification(int $personId, string $status): void
    {
        // This data is normally be provided by IDP via SimpleSAMLphp.
        $attributes = ['username' => ['notification-test-user'], 'organization' => ['Unrecognized organization']];
        $this->notify($this->user(-1, $personId), $attributes);

        // Make sure that we only received one message.
        $this->assertCount(1, $this->mailer->messages);

        // We expect that the toAddress is the merged support email address, not the base support email address.
        $message = $this->mailer->messages[0];
        $this->assertSame('sso-support@example.org', $message['toAddress']);
        $this->assertSame("New $status Single Sign On User Created", $message['subject']);

        // Check that the message contains the user's formal name, username and email address, in addition to specific
        // unique strings that we expect in the "Unknown User Organization" email.
        foreach ([$this->testUserFormalName, $this->testUserUserName, $this->testUserEmailAddress,
                     'Unable to Identify Users Organization.', 'Additional Setup Required.',
                     json_encode($attributes, JSON_PRETTY_PRINT)] as $content) {
            $this->assertStringContainsString($content, $message['body']);
        }

        // We don't expect that there are any error records logged as this is the happy path.
        $this->assertFalse($this->logs->hasErrorRecords());
    }

    /**
     * Data Provider for testUnknownOrganizationSendsNotification that provides data for two test cases:
     *   - An unlinked ( person_id = -1 ) user
     *   - A linked ( person_id != -1 ) user
     *
     * @return array[]
     */
    public static function providePersonLinks(): array
    {
        return ['unlinked' => [UNKNOWN_USER_TYPE, 'Unlinked'], 'linked' => [123, 'Linked']];
    }

    /**
     * Test that when we have a "known" organization ( e.g. organization_id != -1 ), that we do not send a notification
     * and that having a linked user does not change that.
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testKnownOrganizationDoesNotSendNotification(): void
    {
        // Test a known organization and unknown person_id
        $this->notify($this->user(42, UNKNOWN_USER_TYPE), []);

        // Test a known organization and a known person_id
        $this->notify($this->user(42, 123), []);

        // Both tests should have no message and no errors.
        $this->assertSame([], $this->mailer->messages);
        $this->assertFalse($this->logs->hasErrorRecords());
    }

    /**
     * Test that consecutive new SSO user logins results in a seperate message being sent to each, without state
     * leaking between them.
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testMultipleUsersCanBeNotifiedInOneProcess(): void
    {
        $this->notify($this->user(-1, UNKNOWN_USER_TYPE), ['username' => ['first']]);
        $this->notify($this->user(-1, 123), ['username' => ['second']]);

        // We had two users login back to back, so there should be two messages, and they should only contain
        // information about / for that user and no others.
        $this->assertCount(2, $this->mailer->messages);
        $this->assertStringContainsString('Unlinked', $this->mailer->messages[0]['subject']);
        $this->assertStringContainsString('Linked', $this->mailer->messages[1]['subject']);
        $this->assertStringContainsString('first', $this->mailer->messages[0]['body']);
        $this->assertStringContainsString('second', $this->mailer->messages[1]['body']);
    }

    /**
     * Test specifically checks that the `catch` block in `SimpleSamlPhpAuthenticator::handleNotifications` successfully
     * catches and re-throws the original exception. This simulates what happens when `notificationMailer->send` fails.
     *
     * @return void
     */
    public function testMailerFailureIsLoggedAndRethrown(): void
    {
        $failure = new Exception('Notification transport unavailable', 451);
        $this->mailer->failure = $failure;
        try {
            $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
            $this->fail('Expected the mailer exception to propagate.');
        } catch (Exception $exception) {
            $this->assertSame($failure, $exception);
        }

        $this->assertCount(1, $this->mailer->messages);
        $this->assertTrue($this->logs->hasErrorThatContains('Error encountered while emailing'));
        $this->assertTrue($this->logs->hasErrorThatContains('[451] Notification transport unavailable'));
    }

    /**
     * Test that our mailer throws an exception when an invalid recipient is provided.
     *
     * @dataProvider provideInvalidRecipients
     *
     * @param string $recipient the invalid recipient string to be checked.
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testInvalidRecipientIsLoggedAndRethrown(string $recipient): void
    {
        $this->configureRecipients('base-support@example.org', $recipient);

        try {
            $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
            $this->fail('Expected recipient validation to fail.');
        } catch (MailerException $exception) {
            $this->assertSame($this->mailer->failure, $exception);
            $this->assertStringContainsString('Invalid address:', $exception->getMessage());
            $this->assertTrue($this->logs->hasErrorThatContains($exception->getMessage()));
        }

        $this->assertCount(1, $this->mailer->messages);
        $this->assertSame($recipient, $this->mailer->messages[0]['toAddress']);
        $this->assertSame([], $this->mailer->preparedMessages);
        $this->assertTrue($this->logs->hasErrorThatContains('Error encountered while emailing'));
    }

    /**
     * Data provider that contains what is considered an "invalid" recipient of emails of a notification email. This is
     * based on what PHPMailer supports.
     *
     * @return array[]
     */
    public static function provideInvalidRecipients(): array
    {
        return [
            'empty override' => [''],
            'spaces only' => ['   '],
            'tab only' => ["\t"],
            'missing at sign' => ['support.example.org'],
            'missing local part' => ['@example.org'],
            'missing domain' => ['support@'],
            'double at sign' => ['support@@example.org'],
            'multiple at signs' => ['a@b@example.org'],
            'leading local dot' => ['.support@example.org'],
            'trailing local dot' => ['support.@example.org'],
            'consecutive local dots' => ['sup..port@example.org'],
            'local space' => ['sup port@example.org'],
            'domain space' => ['support@exam ple.org'],
            'leading domain hyphen' => ['support@-example.org'],
            'trailing domain hyphen' => ['support@example-.org'],
            'consecutive domain dots' => ['support@example..org'],
            'domain underscore' => ['support@exam_ple.org'],
            'domain URL' => ['support@https://example.org'],
            'domain port' => ['support@example.org:25'],
            'comma separated recipients' => ['a@example.org,b@example.org'],
            'semicolon separated recipients' => ['a@example.org; b@example.org'],
            'display name' => ['Support <support@example.org>'],
            'header injection' => ["support@example.org\r\nBcc: other@example.org"],
            'embedded carriage return' => ["sup\rport@example.org"],
            'embedded newline' => ["sup\nport@example.org"],
            'embedded tab' => ["sup\tport@example.org"],
            'embedded NUL' => ["sup\0port@example.org"],
            'local part over 64 bytes' => [str_repeat('a', 65) . '@example.org'],
            'domain label over 63 bytes' => ['support@' . str_repeat('a', 64) . '.org'],
            'address over 254 bytes' => [str_repeat('a', 64) . '@' . str_repeat(str_repeat('b', 63) . '.', 3) . 'org'],
            'dotless domain' => ['support@localhost'],
            'quoted local part with space' => ['"support team"@example.org'],
        ];
    }

    /**
     * Test that our mailer can handle what we consider to be "valid" recipients.
     *
     * @dataProvider provideValidRecipients
     *
     * @param string $recipient the valid recipient string to be checked.
     * @param string $expected  what we expect the recipient to be after being prepared.
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testValidRecipientIsPreparedWithoutDelivery(string $recipient, string $expected): void
    {
        // A valid override must also replace an invalid base value.
        $this->configureRecipients('not-an-email', $recipient);
        $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);

        $this->assertCount(1, $this->mailer->preparedMessages);
        $mail = $this->mailer->preparedMessages[0];
        $this->assertSame([[$expected, '']], $mail->getToAddresses());
        $this->assertSame([], $mail->getCcAddresses());
        $this->assertSame([], $mail->getBccAddresses());
        $this->assertFalse($this->logs->hasErrorRecords());
    }

    /**
     * Data provider that contains what is considered a "valid" recipient of a notification email. This based on what
     * is supported by PHPMailer
     *
     * @return array[]
     */
    public static function provideValidRecipients(): array
    {
        return [
            'ordinary address' => ['support@example.org', 'support@example.org'],
            'surrounding whitespace' => [" \tsupport@example.org\t ", 'support@example.org'],
            'plus addressing' => ['support+sso@example.org', 'support+sso@example.org'],
            'dots and subdomains' => ['first.last@help.example.org', 'first.last@help.example.org'],
            'uppercase' => ['Support@EXAMPLE.ORG', 'Support@EXAMPLE.ORG'],
            'IPv4 literal' => ['support@[127.0.0.1]', 'support@[127.0.0.1]'],
            'IPv6 literal' => ['support@[IPv6:2001:db8::1]', 'support@[IPv6:2001:db8::1]'],
            '64 byte local part' => [str_repeat('a', 64) . '@example.org', str_repeat('a', 64) . '@example.org'],
            '63 byte domain label' => ['support@' . str_repeat('a', 63) . '.org', 'support@' . str_repeat('a', 63) . '.org'],
            // Syntax validation does not perform DNS or mailbox existence checks.
            'nonexistent domain' => ['support@example.invalid', 'support@example.invalid'],
            '254 byte address' => [str_repeat('a', 64) . '@' . str_repeat(str_repeat('b', 63) . '.', 2) . str_repeat('c', 57) . '.org',
                str_repeat('a', 64) . '@' . str_repeat(str_repeat('b', 63) . '.', 2) . str_repeat('c', 57) . '.org'],
            'punycode domain' => ['support@xn--bcher-kva.example', 'support@xn--bcher-kva.example'],
        ];
    }

    /**
     * Test that our mailer can handle internationalized domain names, when using a version of PHPMailer that supports it.
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testInternationalizedDomainIsPreparedWhenSupported(): void
    {
        if (!PHPMailer::idnSupported()) {
            $this->markTestSkipped('Internationalized domains require intl and mbstring.');
        }
        // MailWrapper leaves PHPMailer's default ISO-8859-1 charset in place.
        $this->configureRecipients('base@example.org', "support@b\xfccher.example");
        $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
        $this->assertSame(
            [['support@xn--bcher-kva.example', '']],
            $this->mailer->preparedMessages[0]->getToAddresses()
        );
        $this->assertFalse($this->logs->hasErrorRecords());
    }

    /**
     * Test that our mailer can handle unicode, when using a version of PHPMailer that supports it.
     *
     * @return void
     *
     * @throws \ReflectionException
     */
    public function testUnicodeLocalPartIsPreparedWhenSupported(): void
    {
        if (version_compare(PHPMailer::VERSION, '6.10.0', '<')) {
            $this->markTestSkipped('Unicode local parts require PHPMailer 6.10 or later.');
        }
        $this->configureRecipients('base@example.org', '用户@example.org');
        $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
        $mail = $this->mailer->preparedMessages[0];
        $this->assertSame([['用户@example.org', '']], $mail->getToAddresses());
        $this->assertTrue($mail->needsSMTPUTF8());
        $this->assertFalse($this->logs->hasErrorRecords());
    }

    /**
     * Tests the mailer behavior when XDMoD's `debug_mode` is enabled and verifies that:
     *   - When in debug_mode, and have a valid debug_recipient, the debug_recipient replaces the support_recipient
     *     when emails are sent. No errors are expected.
     *   - When in debug_mode, and an invalid debug_recipient is specified, we expect that an exception will be thrown.
     *
     * @dataProvider provideDebugRecipients
     *
     * @param string $debugRecipient
     * @param bool   $valid
     *
     * @return void
     * @throws \ReflectionException
     */
    public function testDebugRecipientReplacesInvalidSupportRecipient(string $debugRecipient, bool $valid): void
    {
        $this->configureRecipients('base@example.org', 'invalid-support', [
            'debug_mode' => 'on',
            'debug_recipient' => $debugRecipient,
        ]);
        try {
            $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
            $this->assertTrue($valid, 'Expected invalid debug recipient to fail.');
        } catch (MailerException $exception) {
            $this->assertFalse($valid);
            $this->assertSame($this->mailer->failure, $exception);
            $this->assertTrue($this->logs->hasErrorThatContains($exception->getMessage()));
        }
        if ($valid) {
            $this->assertSame([[$debugRecipient, '']], $this->mailer->preparedMessages[0]->getToAddresses());
            $this->assertFalse($this->logs->hasErrorRecords());
        } else {
            $this->assertSame([], $this->mailer->preparedMessages);
            $this->assertTrue($this->logs->hasErrorThatContains('Error encountered while emailing'));
        }
    }

    /**
     * Data provider for testing debug recipient configuration.
     *
     * @return array[]
     */
    public static function provideDebugRecipients(): array
    {
        return ['valid debug recipient' => ['debug@example.org', true], 'invalid debug recipient' => ['invalid', false]];
    }

    /**
     * Helper function that configures the base and override configuration files and takes care of shutting down /
     * booting the kernel so that the new values will be used by the kernels services ( authenticator, mailer etc. )
     *
     * @param string $base     the base tech_support_recipient value.
     * @param string $override the override tech_support_recipient value.
     * @param array  $general  a string keyed array of additional values to include in the override configuration.
     *
     * @return void
     */
    private function configureRecipients(string $base, string $override, array $general = []): void
    {
        // Helper static function to escape double quotes within a string.
        $quote = static fn(string $value): string => '"' . str_replace('"', '\\"', $value) . '"';

        // Shutdown the test kernel so that we can update the configuration file contents.
        $this->kernel->shutdown();

        // Write out the base configuration.
        file_put_contents($this->directory . '/portal_settings.ini',
                          "[general]\ntitle = Test\ndebug_mode = off\ntech_support_recipient = " . $quote($base)
                          . "\n[mailer]\nsender_email = sender@example.org\n");

        // Build and write out the override configuration.
        $contents = "[general]\ntech_support_recipient = " . $quote($override) . "\n";
        foreach ($general as $key => $value) {
            $contents .= $key . ' = ' . $quote($value) . "\n";
        }
        file_put_contents($this->directory . '/portal_settings.d/support.ini', $contents);

        // Now that we have the new configuration data in place, boot the the test kernel and re-pull the member
        // variables used in testing.
        $this->kernel->boot();
        $container = $this->kernel->getContainer();
        $this->authenticator = $container->get(SimpleSamlPhpAuthenticator::class);
        $this->mailer = $container->get(RecordingNotificationMailer::class);
        $this->logs = $container->get('test.notification_logs');

        // Lastly, if we're configuring recipients, then we're also validating them.
        $this->mailer->validateRecipients = true;
    }

    /**
     * Test that missing recipient configuration fails visibly before attempting delivery.
     *
     * @return void
     */
    public function testMissingRecipientIsLoggedAndRethrown(): void
    {
        // Shutdown the test kernel so that we can update the configuration file contents.
        $this->kernel->shutdown();

        // Specifically, we're ensuring that there is no tech_support_recipient property specified.
        file_put_contents($this->directory . '/portal_settings.ini', "[general]\ntitle = Test\n");
        unlink($this->directory . '/portal_settings.d/support.ini');

        // Boot the kernel again so that the updated configuration file contents are loaded and re-retrieve the
        // authenticator, mailer and logs
        $this->kernel->boot();
        $container = $this->kernel->getContainer();
        $this->authenticator = $container->get(SimpleSamlPhpAuthenticator::class);
        $this->mailer = $container->get(RecordingNotificationMailer::class);
        $this->logs = $container->get('test.notification_logs');


        // Now we can conduct the actual test, specifically this tests that the retrieval of the tech_support_recipient
        // throws an exception as it's missing from the configuration file.
        try {
            $this->notify($this->user(-1, UNKNOWN_USER_TYPE), []);
            $this->fail('Expected missing recipient configuration to fail.');
        } catch (Exception $exception) {
            $this->assertSame("Option 'tech_support_recipient' does not exist in section 'general'", $exception->getMessage());
        }

        // Since we have no recipient, we should have no messages
        $this->assertSame([], $this->mailer->messages);
        // Also, since we have no recipient, an error should have been logged
        $this->assertTrue($this->logs->hasErrorThatContains('Error encountered while emailing'));
    }
}

// ============================================================================
// Below you'll find:
//   - RecordingNotificationMailer: Allows us to provide a custom implementation of NotificationMailerInterface that
//     we'll wire in to the custom Symfony Kernel that records delivery requests without invoking sendmail.
//   - NotificationTestKernel: A custom Symfony Kernel that wires up all the services and dependencie for conducting
//     these tests. Keeping all files cache/log/configuration together in the temporary directory generated for each
//     test.
// ============================================================================

/**
 * Custom NotificationMailer class that records delivery requests without invoking sendmail or contacting recipients.
 * When validating recipients, we'll use our MailWrapper's configured PHPMailer instance's `preSend` function.
 */
class RecordingNotificationMailer implements NotificationMailerInterface
{
    /**
     * The messages "sent" by this notification mailer are stored here.
     */
    public array $messages = [];

    /**
     * If a failure occurs or is expected during message delivery, it will be stored here.
     */
    public ?Exception $failure = null;

    /**
     * Indicate that the recipients of the message should be validated. This actually utilizes our MailWrapper
     * configured instance of PHPMailer and it's `preSend` function for the validation.
     */
    public bool $validateRecipients = false;

    /**
     * When `validateRecipients` is true, this array will contain the PHPMailer instance used for validation.
     */
    public array $preparedMessages = [];

    public function __construct(
        /**
         * Used during validation of recipients. Specifically used to populate the `general` and `mailer` sections
         * of the global iniData.
         */
        private IniConfiguration $configuration
    ) {}

    /**
     * Implementation of the NotificationMailerInterface::send function. Stores the "sent" email for later reference.
     * Optionally, when `validateRecipients` is true, this function will also validate the recipients using a PHPMailer
     * instance from our `MailWrapper::initPHPMailer` function.
     *
     * @param array $properties
     *
     * @return void
     * @throws MailerException
     */
    public function send(array $properties): void
    {
        $this->messages[] = $properties;
        if ($this->failure !== null) {
            throw $this->failure;
        }

        // If the test is to validate recipients, then we need to check this w/ PHPMailer directly as that's what
        // we're using.
        if ($this->validateRecipients) {
            // The legacy wrapper reads global configuration. Scope it to the same test
            // settings as the authenticator and restore it even when validation fails.
            $hadIniData = array_key_exists('iniData', $GLOBALS);
            $previousIniData = $GLOBALS['iniData'] ?? null;
            $previousValidator = PHPMailer::$validator;
            try {
                $GLOBALS['iniData'] = [
                    'general' => $this->configuration->getConfigurationSection('general'),
                    'mailer' => $this->configuration->getConfigurationSection('mailer'),
                ];
                $mail = MailWrapper::initPHPMailer($properties);
                // Also validates deferred IDN recipients, but never invokes a transport.
                $mail->preSend();
                $this->preparedMessages[] = $mail;
            } catch (Exception $exception) {
                $this->failure = $exception;
                throw $exception;
            } finally {
                PHPMailer::$validator = $previousValidator;
                if ($hadIniData) {
                    $GLOBALS['iniData'] = $previousIniData;
                } else {
                    unset($GLOBALS['iniData']);
                }
            }
        }
    }
}

/**
 * The custom Symfony test kernel that allows us to substitute our fixtures and record dependencies for these tests.
 * It uses the temporary directory created in PHPUnit's `setUp` to store test related cache, log and configuration
 * files.
 */
class NotificationTestKernel extends Kernel
{
    public function __construct(private string $directory)
    {
        parent::__construct('prod', false);
    }

    public function getCacheDir(): string
    {
        return $this->directory . '/cache';
    }

    public function getLogDir(): string
    {
        return $this->directory . '/logs';
    }

    protected function build(ContainerBuilder $container): void
    {
        parent::build($container);

        // Here is where we setup all the necessary services for our tests.
        $container->addCompilerPass(
            new class($this->directory) implements CompilerPassInterface {
                public function __construct(private string $directory) {}

                public function process(ContainerBuilder $container): void
                {
                    $container->setParameter('log_dir', $this->directory . '/logs');
                    $container->getDefinition(IniConfiguration::class)
                        ->setArgument('$iniFilePath', $this->directory . '/portal_settings.ini');
                    $container->register(RecordingNotificationMailer::class, RecordingNotificationMailer::class)
                        ->setArgument('$configuration', new Reference(IniConfiguration::class))
                        ->setPublic(true);
                    $container->register('test.notification_logs', TestHandler::class)->setPublic(true);
                    $container->register('test.notification_logger', Logger::class)
                        ->setArguments(['notification_test', [new Reference('test.notification_logs')]]);
                    $container->getDefinition(SimpleSamlPhpAuthenticator::class)
                        ->setArgument('$notificationMailer', new Reference(RecordingNotificationMailer::class))
                        ->setArgument('$logger', new Reference('test.notification_logger'))
                        ->setPublic(true);
                }
            }
        );
    }
}
