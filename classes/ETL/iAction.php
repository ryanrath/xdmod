<?php
/* ==========================================================================================
 * An individual action performs some task, such as an ingestor or aggregator. iAction defines the
 * required methods for implementation. The aAction abstract helper class encapsulates some common
 * functionality and should be extended by action implementations.
 *
 * @author Steve Gallo <smgallo@buffalo.edu>
 * @date 2015-11-01
 *
 * @see aAction
 * ==========================================================================================
 */

namespace ETL;

use ETL\Configuration\EtlConfiguration;
use Psr\Log\LoggerInterface;

interface iAction
{
    /**
     * Set up the action. This typically entails verifying that the data endpoints are of the
     * correct type and setting up configuration and option information.
     *
     * @param aOptions $options Options specific to this action, typically parsed from the
     *   ETL configuration file.
     * @param EtlConfiguration $etlConfig The complete ETL configuration as parsed from the
     *   configuration file.
     * @param LoggerInterface $logger A Monolog Logger object or null to use the null logger.
     */

    public function __construct(aOptions $options, EtlConfiguration $etlConfig, LoggerInterface $logger = null);

    /**
     * Execute the action.
     *
     * @param EtlOverseerOptions $etlOptions Options set for this ETL run.
     */

    public function execute(EtlOverseerOptions $etlOptions);

    /**
     * Perform initialization and verification on this action before executing it,
     * allowing us to detect configuration errors. We pass the EtlOverseerOptions here
     * because verification may occur pre-execution. Since multiple classes may implement
     * iAction::initialize(), null may be passed to parent::initialize() so there are not
     * multiple assignments of large objects.
     *
     * This must occur AFTER the constructor calls has completed and should be called
     * prior to verification and/or execution.
     *
     * @param EtlOverseerOptions $etlOverseerOptions Options set for this ETL run. This may be null
     *   if it was set elsewhere in the chain.
     *
     * @return boolean TRUE if verification was successful
     */

    public function initialize(EtlOverseerOptions $etlOverseerOptions = null);

    /**
     * @return string The name of the action.
     */

    public function getName();

    /**
     * @return string The class name that implements the action.
     */

    public function getClass();

    /**
     * @return aOptions The action options object
     */

    public function getOptions();

    /**
     * @return string The current start date that this action is operating on.
     */

    public function getCurrentStartDate();

    /**
     * @return string The current end date that this action is operating on.
     */

    public function getCurrentEndDate();

    /**
     * @return boolean TRUE if this action supports chunking of the overall ETL start and end date
     *   into smaller pieces to make it more manageable.
     */

    public function supportsDateRangeChunking();

    /**
     * The ETL overseer provides the ability to specify parameters that are interpreted as
     * restrictions on actions such as the ETL start/end dates and resources to include or
     * exclude from the ETL process.  However, in some cases these options may be
     * overriden by the configuration of an individual action such as resources to include
     * or exclude for that action.
     *
     * @return array An associative array of optional overrides to overseer restrictions.
     */

    public function getOverseerRestrictionOverrides();

    /**
     * @return TRUE if initialization has been performed on this action.
     */

    public function isInitialized();

    /**
     * @return TRUE if this action is enabled, FALSE otherwise.
     */

    public function isEnabled();

    /**
     * Generate a string representation of the action. This typically includes the name, plus other
     * pertinant information as appropriate such as the implementing class.
     *
     * @return string A human-readable representation of the endpoint
     */

    public function __toString();
}  // interface iAction
