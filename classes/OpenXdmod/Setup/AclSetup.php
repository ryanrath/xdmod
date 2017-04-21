<?php namespace OpenXdmod\Setup;

class AclSetup extends SetupItem
{

    /**
     * Handle the setup.
     */
    public function handle()
    {
        $this->console->displaySectionHeader('Acl Setup');
        $this->console->displayMessage(<<<MSG
Please provide the following information specific to your installation.
It is possible to let the script attempt to figure out the best values 
to use, but if you have a highly customized installation you will want
to input the values to the best of your knowledge.

Note: If you would like to execute this script outside of the setup script it is
located at: <xdmod_install_dir>/bin/acl-xdmod-management
MSG
        );
        $this->console->displayBlankLine();

        $baseDirectory = $this->console->prompt(
            'XDMoD Base Directory:',
            realpath(BASE_DIR . DIRECTORY_SEPARATOR . '..')
        );

        $configDirectory = $this->console->prompt(
            'XDMoD Configuration Directory:',
            CONFIG_DIR
        );

        $configFile = $this->console->prompt(
            'ETL Configuration File:',
            realpath(CONFIG_DIR.'/etl/etl.json')
        );

        $etlSection = $this->console->prompt(
            'ETL Section:',
            'acls-xdmod-management'
        );

        $etlAction = $this->console->prompt(
            'ETL Action:',
            'AclTableManagement'
        );

        $dryRun = $this->console->promptBool(
            'Execute Dry Run:',
            false
        );

        $verbose = $this->console->promptBool(
            'Verbose:',
            false
        );

        $oldWD = getcwd();
        $binPath = BASE_DIR . DIRECTORY_SEPARATOR . '..'. DIRECTORY_SEPARATOR . 'bin';
        $binDirectory = realpath($binPath);

        chdir($binDirectory);

        $params = array(
            '-b',
            $baseDirectory,
            '-d',
            $configDirectory,
            '-c',
            $configFile,
            '-s',
            $etlSection,
            '-a',
            $etlAction
        );

        if (true === $dryRun) {
            $params [] = '-t';
        }

        if (true === $verbose) {
            $params [] = '-v';
        }
        $script = realpath($binDirectory . DIRECTORY_SEPARATOR . 'acl-xdmod-management');
        $cmd = "$script ". implode(' ', $params);

        $output = shell_exec($cmd);

        $hadError = strpos($output, 'error') !== false;

        chdir($oldWD);

        if ($hadError == true) {
            $this->console->displayBlankLine();
            $this->console->displayMessage(<<<MSG
There was an error when attempting to execute the the script with the provided
parameters. Please see the output below, make any corrections necessary and
re-run this setup.

$output
MSG
            );
        } else {
            $this->console->displayBlankLine();
            $this->console->displayMessage(<<<MSG
The script executed without error.
MSG
            );
            $displayOutput = $this->console->promptBool(
                'Do you want to see the output?',
                false
            );
            if (true === $displayOutput) {
                $this->console->displayMessage($output);
                $this->console->prompt('Press Any Key To Continue.');
            }
        }
    }
}
