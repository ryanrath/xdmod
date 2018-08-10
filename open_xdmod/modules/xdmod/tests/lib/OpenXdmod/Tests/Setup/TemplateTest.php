<?php
/**
 * @author Jeffrey T. Palmer <jtpalmer@buffalo.edu>
 */

namespace OpenXdmod\Tests\Setup;

use TestHarness\TestFiles;
use Xdmod\Template;

/**
 * Template test class.
 */
class TemplateTest extends \PHPUnit_Framework_TestCase
{

    private $testFiles;

    /**
     * TemplateTest constructor.
     * @param $name
     * @param $data
     * @param $dataName
     * @throws \Exception
     */
    public function __construct($name = null, $data = array(), $dataName = '')
    {
        $baseDir = implode(
            DIRECTORY_SEPARATOR,
            array(
                __DIR__,
                './../../../../'
            )
        );

        $this->testFiles = new TestFiles($baseDir);
        parent::__construct($name, $data, $dataName);
    }


    /**
     * Test to make sure the template portal_settings.ini matches the
     * default portal_settings.ini file.
     */
    public function testPortalSettingsTemplate()
    {
        $portalSettingsPath = $this->testFiles->getFile('templates', 'portal_settings', 'output', '.ini');

        $defaultContents = file_get_contents($portalSettingsPath);
        $data = $this->getSettingsData($portalSettingsPath);

        $template = new Template('portal_settings');
        $template->apply($data);

        $this->assertEquals($defaultContents, $template->getContents());
    }

    /**
     * Get data from an INI file.
     *
     * @param string $path INI file path.
     *
     * @return array
     */
    protected function getSettingsData($path)
    {
       $data = parse_ini_file($path, true);

        if ($data === false) {
            throw new Exception("Failed to parse '$path'");
        }

        $settings = array();

        foreach ($data as $sectionName => $sectionData) {
            foreach ($sectionData as $key => $value) {
                $settings[$sectionName . '_' . $key] = $value;
            }
        }

        return $settings;
    }
}
