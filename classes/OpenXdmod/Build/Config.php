<?php
/**
 * @author Jeffrey T. Palmer <jtpalmer@buffalo.edu>
 */

namespace OpenXdmod\Build;

use Exception;
use CCR\Json;

/**
 * Open XDMoD build configuration class.
 */
class Config
{
    private $name;

    private $version;

    private $release;

    private $fileIncludePaths;

    private $fileIncludePatterns;

    private $fileExcludePaths;

    private $fileExcludePatterns;

    private $fileMaps;

    private $commandsPreBuild;

    public static function createFromConfigFile($file)
    {
        $config = Json::loadFile($file);

        if (!isset($config['name'])) {
            throw new Exception("No module name specified in '$file'");
        }

        if (!isset($config['version'])) {
            throw new Exception("No version specified in '$file'");
        }

        if (!isset($config['release'])) {
            $config['release'] = 1;
        }

        if (!isset($config['files'])) {
            throw new Exception("No files specified in '$file'");
        }

        $fileIncludePaths
            = isset($config['files']['include_paths'])
            ? $config['files']['include_paths']
            : array();

        $fileIncludePatterns
            = isset($config['files']['include_patterns'])
            ? $config['files']['include_patterns']
            : array();

        $fileExcludePaths
            = isset($config['files']['exclude_paths'])
            ? $config['files']['exclude_paths']
            : array();

        $fileExcludePatterns
            = isset($config['files']['exclude_patterns'])
            ? $config['files']['exclude_patterns']
            : array();

        $fileMaps
            = isset($config['file_maps'])
            ? static::normalizeFileMaps($config['file_maps'])
            : array();

        $commandsPreBuild
            = isset($config['commands']['pre_build'])
            ? $config['commands']['pre_build']
            : array();

        $templateBaseDirectory
            = isset($config['template_options']['base_directory'])
            ? $config['template_options']['base_directory']
            : "";

        $templateDirectories
            = isset($config['template_options']['directories'])
            ? $config['template_options']['directories']
            : array();

        return new static(array(
            'name'                  => $config['name'],
            'version'               => $config['version'],
            'release'               => $config['release'],
            'file_include_paths'    => $fileIncludePaths,
            'file_include_patterns' => $fileIncludePatterns,
            'file_exclude_paths'    => $fileExcludePaths,
            'file_exclude_patterns' => $fileExcludePatterns,
            'file_maps'             => $fileMaps,
            'commands_pre_build'    => $commandsPreBuild,
            'template_base_directory' => $templateBaseDirectory,
            'template_directories'    => $templateDirectories
        ));
    }

    /**
     * Normalize file maps into a form that can easily be used by the
     * installation script.
     *
     * Two top level formats are supported for each file map section,
     * in JSON notation these are either an array or object, e.g.:
     *
     *     "bin": [
     *     ],
     *     "doc": {
     *     }
     *
     * All key/value pairs are treated uniformally in the object-style
     * map.  Elements of an array in the array-style format element must
     * either be a string or an object.  If the element of the array is
     * an object, it should contain a single key/value pair and will be
     * handled using the same rules that are applied to the top level
     * object-style format. The two following examples are equivalent:
     *
     *     "bin": [
     *         { "path/to/source": "path/to/destination" }
     *     ]
     *
     *     "bin": {
     *        "path/to/source": "path/to/destination"
     *     }
     *
     * In addition to copying files by specifying both their full
     * relative paths, several abbreviated formats are supported.
     *
     * Copying a file or directory into the base of the destination:
     *
     *     "bin": [
     *         "path/to/source"
     *     ]
     *
     *     "bin": {
     *         "path/to/source": ""
     *     }
     *
     *     "bin": {
     *         "path/to/source": "source"
     *     }
     *
     * Preserving the relative path of the source file when copying:
     *
     *     "bin": {
     *         "path/to/source": true
     *     }
     *
     *     "bin": {
     *         "path/to/source": "path/to/source"
     *     }
     *
     * Copying the contents of a folder:
     *
     *     "bin": {
     *         "path/to/bin/": ""
     *     }
     *
     * @param array $map An associative array of file maps where the key
     *   is the section name (e.g. "bin", "etc") and the value is the
     *   map for the files that are installed in that section.
     *
     * @return array An associate array of file maps where the key is
     *   the section name and the value is the normalized file map.
     */
    private static function normalizeFileMaps(array $maps)
    {
        return array_map(array(__CLASS__, 'normalizeFileMap'), $maps);
    }

    /**
     * Normalize a file map.
     *
     * @param array
     *
     * @see normalizeFileMaps
     */
    private static function normalizeFileMap(array $map)
    {
        // Convert numeric arrays to be associative.
        if (!(bool)count(array_filter(array_keys($map), 'is_string'))) {
            $assocMap = array();

            foreach ($map as $index => $value) {
                if (is_array($value)) {
                    $assocMap = array_merge($assocMap, $value);
                } else {
                    $assocMap[$value] = '';
                }
            }

            $map = $assocMap;
        }

        $normalizedMap = array();

        foreach ($map as $src => $dest) {
            $normalizedMap[$src] = static::normalizeFileMapDestination($src, $dest);
        }

        return $normalizedMap;
    }

    /**
     * Normalize the destination of a file map.
     *
     * @param string $src The file map source path.
     * @param string $dest The unnormalized file map destination path.
     *
     * @return string The normalized destination path.
     *
     * @see normalizeFileMaps
     */
    private static function normalizeFileMapDestination($src, $dest)
    {
        if ($dest === true) {
            return $src;
        } elseif ($dest !== '') {
            return $dest;
        } else {
            $pathParts = explode('/', $src);

            // Trailing "/" indicates that the contents of the directory should
            // be copied into the destination.
            if (substr($src, -1) === '/') {
                return '';
            } else {
                return $pathParts[count($pathParts) - 1];
            }
        }
    }

    /**
     * This function will attempt to, given a version string, parse out the
     * components of a semver compliant version number.
     *
     * @param string $version the version as provided by the file 'build.json'
     **/
    private function setVersionDetails($version)
    {
        $MAJOR = 1;
        $MINOR = 2;
        $PATCH = 3;
        $PRE_RELEASE = 4;

        $matches = array();
        preg_match("/(\d+)?\.(\d+)?\.?(\d+)?\.?-?([0-9A-Za-z-.]+)?/", $version, $matches);
        $length = count($matches);
        for ($i = 1; $i < $length; $i++) {
            switch ( $i ) {
                case $MAJOR:
                    $this->versionMajor = trim($matches[$i]);
                    break;
                case $MINOR:
                    $this->versionMinor = trim($matches[$i]);
                    break;
                case $PATCH:
                    $this->versionPatch = trim($matches[$i]);
                    break;
                case $PRE_RELEASE:
                    $this->versionPreRelease = trim($matches[i]);
                    break;
            }
        }
    }

    private function __construct(array $conf)
    {
        $this->name    = $conf['name'];
        $this->version = $conf['version'];
        $this->release = $conf['release'];

        $this->fileIncludePaths    = $conf['file_include_paths'];
        $this->fileIncludePatterns = $conf['file_include_patterns'];
        $this->fileExcludePaths    = $conf['file_exclude_paths'];
        $this->fileExcludePatterns = $conf['file_exclude_patterns'];

        $this->fileMaps = $conf['file_maps'];

        $this->commandsPreBuild = $conf['commands_pre_build'];

        $this->templateBaseDirectory = $conf['template_base_directory'];
        $this->templateDirectories = $conf['template_directories'];

        $this->setVersionDetails($this->version);
    }

    public function getName()
    {
        return $this->name;
    }

    public function getVersion()
    {
        return $this->version;
    }

    /**
     * Retrieve the 'major' portion of this module's version number.
     * Ex. 6.6.0-rc1
     *     ^
     * in this example the first '6' is the major portion of the version number.
     **/
    public function getVersionMajor()
    {
        return $this->versionMajor;
    }

    /**
     * Retrieve the 'minor' portion of this module's version number.
     * Ex. 6.6.0-rc1
     *       ^
     * in this example the second '6' is the major portion of the version
     * number.
     **/
    public function getVersionMinor()
    {
        return $this->versionMinor;
    }

    /**
     * Retrieve the 'patch' portion of this module's version number.
     * Ex. 6.6.0-rc1
     *         ^
     * in this example the '0' is the patch portion of the version number.
     **/
    public function getVersionPatch()
    {
        return $this->versionPatch;
    }

    /**
     * Retrieve the 'pre-release' portion of this module's version number.
     * Ex. 6.6.0-rc1
     *           ^^^
     * in this example the 'rc1' is the pre-release portion of the version
     * number.
     *
     * Note: Anything after the '-' character will be stored here.
     **/
    public function getVersionPreRelease()
    {
        return $this->versionPreRelease;
    }

    public function getRelease()
    {
        return $this->release;
    }

    public function getFileIncludePaths()
    {
        return $this->fileIncludePaths;
    }

    public function getFileIncludePatterns()
    {
        return $this->fileIncludePatterns;
    }

    public function getFileExcludePaths()
    {
        return $this->fileExcludePaths;
    }

    public function getFileExcludePatterns()
    {
        return $this->fileExcludePatterns;
    }

    public function getFileMaps()
    {
        return $this->fileMaps;
    }

    public function getCommandsPreBuild()
    {
        return $this->commandsPreBuild;
    }

    public function getTemplateBaseDirectory()
    {
        return $this->templateBaseDirectory;
    }

    public function getTemplateDirectories()
    {
        return $this->templateDirectories;
    }
}
