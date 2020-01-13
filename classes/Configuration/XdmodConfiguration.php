<?php

namespace Configuration;

use Exception;
use stdClass;

/**
 * Class XdmodConfiguration
 *
 * This class adds the ability for configuration files to have `extends` properties processed.
 *
 * The `extends` property is processed via the following steps:
 *   - We find all of the configuration entries that have a property matching:
 *     `extends: '<some string>'` and gather them into an array of the format:
 *     array(
 *         'extender1' => 'extendee1',
 *         'extender2' => 'extendee2'
 *          etc. etc.
 *     )
 *     NOTE: an entity that extends one thing, can itself be extended by another.
 *  - for each entry in this `extender` => `extendee` array we:
 *    - We next collect a unique list of `extendees` into an array.
 *    - We then find all of the entries that extend these extendees
 *    - We next diff the unique extendee list w/ the extenders to find those entries that do not
 *      themselves extend something. You can think of these entries as the root of the dependency tree.
 *    - Next, we find all of the entries that extend these root entries.
 *    - Now we resolve `extends` for these "first-level" extenders. The resolution process is as
 *      follows:
 *        - Recursively iterate through configuration that is resolving extends
 *        - If one of the current objects keys matches one of those who defines an `extends` keyword
 *          then:
 *            - iterate through the current object and find the `extendee`, returning it's value.
 *            - If one is not found then an exception will be thrown, else
 *            - We merge the `extendee` into the `extender`. This follows the same merge logic that is
 *              used for merging local config files into a main config file.
 *            - finally, the `extends` property is removed from the parent object.
 *     - Finally, we unset each processed `$extender` from the array that we are processing so that
 *       we eventually finish.
 * @package Configuration
 */
class XdmodConfiguration extends Configuration
{

    const EXTENDS_KEYWORD = 'extends';

    /**
     * @see Configuration::postMergeTasks()
     *
     * @return Configuration
     * @throws Exception
     */
    protected function postMergeTasks()
    {
        parent::postMergeTasks();

        $this->processExtends();

        $this->processReplacements();

        $this->processFilters();

        return $this;
    }

    /**
     * Provides a function that can be overwritten in child classes for controlling which data
     * structures are processed for `extends` keywords.
     *
     * @throws Exception if unable to correctly resolve the `extends` property.
     */
    protected function processExtends()
    {
        // This objects `transformedConfig` may be an object or an array of objects, this is handled
        // by the following `if/elseif` statement.
        if (!$this->isLocalConfig) {
            if (is_array($this->transformedConfig)) {
                foreach($this->transformedConfig as $key => &$value) {
                    if (is_object($value)) {
                        $this->handleExtendsFor($value);
                    }
                }

            } elseif(is_object($this->transformedConfig)) {
                $this->handleExtendsFor($this->transformedConfig);
            }
        }
    } // processExtends

    protected function processReplacements()
    {
        if (!$this->isLocalConfig) {
            if (is_array($this->transformedConfig)) {
                foreach($this->transformedConfig as $key => &$value) {
                    if (is_object($value)) {
                        $this->handleReplacementsFor($value);
                    }
                }
            } elseif (is_object($this->transformedConfig)) {
                $this->handleReplacementsFor($this->transformedConfig);
            }
        }
    }

    /**
     * @throws Exception
     */
    protected function processFilters()
    {
        if (!$this->isLocalConfig) {
            if (is_array($this->transformedConfig)) {
                foreach($this->transformedConfig as $key => &$value) {
                    if (is_object($value)) {
                        $this->transformedConfig[$key] = $this->handleFiltersFor($value);
                    }
                }
            } elseif (is_object($this->transformedConfig)) {
                $this->transformedConfig = $this->handleFiltersFor($this->transformedConfig);
            }
        }
    }

    /**
     * This function will handle the `extends` keyword for the provided $source object. This will
     * result in merging properties from the `extends` target into the object that defined the
     * `extends` property. After the processing is done the `extends` property will be removed.
     *
     * @param stdClass $source
     * @throws Exception
     */
    protected function handleExtendsFor(stdClass $source)
    {

        $extends = $this->findExtends($source);

        // only operate as long as there is something left to extend
        while (count($extends) > 0) {

            // The things being extended
            $targets = array_unique(array_values($extends));

            // the extenders of said things
            $children = array_keys($extends);

            // finding the extended that do not themselves extend something. aka the bottom of the
            // dependency tree.
            $roots = array_diff($targets, $children);

            // finding the everything that extends these root elements.
            $extenders = array_keys(
                array_filter(
                    $extends,
                    function ($key) use ($roots) {
                        return in_array($key, $roots);
                    }
                )
            );

            // Actually do the extending.
            $this->resolveExtends($source, $extenders);

            // Now that we've finished extending $extenders, remove them so we don't process them
            // again
            foreach ($extenders as $extender) {
                unset($extends[$extender]);
            }
        }
    }

    /**
     * @param stdClass $source
     */
    protected function handleReplacementsFor(stdClass $source)
    {
        #$replacements = $this->findReplacements();

    }

    /**
     * @param stdClass $source
     * @return stdClass
     * @throws Exception
     */
    protected function handleFiltersFor(stdClass $source)
    {
        $filters = array_filter(
            get_object_vars($source),
            function($key) {
                return $key[0] === '-';
            },
            ARRAY_FILTER_USE_KEY
        );

        $source = $this->applyFilters($source, $filters);

        // Clean Up the source object so that the filter values are no longer present.
        $filterKeys = array_keys($filters);
        foreach($filterKeys as $filterKey) {
            unset($source->$filterKey);
        }

        return $source;
    }

    protected function findFilters(stdClass $source)
    {
        $results = array();
    }

    /**
     * @param stdClass $source
     * @param iterable $filters
     * @return stdClass
     * @throws Exception
     */
    protected function applyFilters(stdClass &$source, $filters)
    {
        foreach($filters as $rawProperty => $value) {
            if ($rawProperty[0] !== '-') {
                continue;
            }

            $property = substr($rawProperty, 1);

            // If the filter value is empty ( '', [], {} etc. ) && source has a $property then we should remove it.
            if (empty($value) && isset($source->$property)) {
                unset($source->$property);
            } elseif (isset($source->$property)) {
                // we have a property *and* the filter value is not empty. We should continue processing the values.
                if (is_object($value)) {
                    $source->$property = $this->applyFilters($source->$property, $value);
                } elseif (is_array($value) && !empty($value) && is_array($source->$property)) {
                    $toBeRemoved = $this->filterArray($source->$property, $value);
                    foreach($toBeRemoved as $index) {
                        $rest = array_slice($source->$property, 0, $index);
                        $rest = array_merge($rest, array_slice($source->$property, $index + 1));
                        $source->$property = $rest;
                    }
                }
            }
        }
        return $source;
    }

    protected function filterArray(array $source, array $filters)
    {
        $results = array();
        foreach($source as $key => $value) {
            foreach($filters as $filter) {
                $filterKeys = array_keys(get_object_vars($filter));
                $valueKeys = array_keys(get_object_vars($value));

                $same = array_intersect($filterKeys, $valueKeys);

                $include = true;
                if (!empty($same)) {
                    foreach($same as $sameProperty) {
                        $expected = $filter->$sameProperty;
                        $actual = $value->$sameProperty;
                        if ($actual !== $expected) {
                            $include = false;
                            break;
                        }
                    }
                }

                if ($include === true) {
                    $results[] = $key;
                }
            }
        }
        return $results;
    }


    /**
     * Iterate through $config and find any objects that contain an `extends` property for later
     * processing.
     *
     * The returned array will be in the form:
     * array(
     *   'extender' => 'extendee',
     *    ...
     * )
     *
     * a concrete example would be:
     * array(
     *   'usr' => 'default', // usr extends default
     *   'pi'  => 'usr',     // pi extends usr
     *   'cs'  => 'pi',      // cs extends pi
     *   'cd'  => 'cs'       // cd extends cs
     * )
     *
     * @param stdClass $config the object that is being iterated over.
     * @param string|null $parentKey the key of the object that contains `extends`.
     * @return array in the form:
     * array(
     *   'extender' => 'extendee'
     * )
     * @throws Exception
     */
    protected function findExtends(\stdClass $config, $parentKey = null)
    {
        $extends = array();
        foreach ($config as $k => $v) {
            if ($k === self::EXTENDS_KEYWORD && $parentKey === null) {
                $this->logAndThrowException(
                    sprintf(
                        "Invalid configuration format in %s, `extends` is not supported at the root level of a configuration file.",
                        $this->getFilename()
                    )
                );
            } elseif($k === self::EXTENDS_KEYWORD && is_string($v)) {
                $extends[$parentKey] = $v;
            } elseif(is_object($v)) {
                $extends = array_merge($extends, $this->findExtends($v, $k));
            }
        }
        return $extends;
    }

    /**
     * Modify the properties in $config that are also found in $extenders by merging in their
     * `extends` target. This function does not handle the overall ordering of extension, this must
     * be controlled by the caller.
     *
     * NOTE: After an `extends` property has been successfully merged, it will itself be unset and
     * therefor not present in the resultant object.
     *
     * @param stdClass $config the base object that will be recursively traversed to find and
     * resolve instances of the `extends` property.
     * @param string[] $extenders the array of property keys whose values define an `extends`
     * property.
     * @throws Exception if unable to resolve the merging of an extender and it's extendee.
     */
    protected function resolveExtends(\stdClass $config, array $extenders)
    {
        $extendsProperty = self::EXTENDS_KEYWORD;
        foreach ($config as $k => $v) {
            if (in_array($k, $extenders)) {
                $target = $this->findByKey($v->$extendsProperty, $config);
                if ($target === null) {
                    $this->logAndThrowException(
                        sprintf(
                            "Unable to find %s target %s",
                            $extendsProperty,
                            json_encode($v)
                        )
                    );
                }

                $config->$k = $this->mergeLocal($v, $target, "extending-{$v->$extendsProperty}", false, false);

                unset($config->$k->$extendsProperty);
            } elseif (is_object($v)) {
                $this->resolveExtends($v, $extenders);
            }
        }

    }

    /**
     * Find $key in this `Configuration`s `transformedConfig` and return it's value. If not found,
     * null will be returned.
     *
     * @param string $key the key being looked for in $incoming ( or `transformedConfig`
     *                                if $incoming is not set. )
     * @param stdClass|null $incoming the stdClass to be searched for key.
     * @return mixed|null `$key`s value if found, else null.
     */
    protected function findByKey($key, $incoming = null)
    {
        if (null === $incoming) {
            $incoming = $this->transformedConfig;
        }
        foreach ($incoming as $k => $v) {
            if ($k === $key) {
                return $v;
            } elseif (is_object($v)) {
                $found = $this->findByKey($key, $v);
                if ($found !== null) {
                    return $found;
                }
            }
        }
        return null;
    }

    /**
     * @see iConfiguration::__sleep()
     */

    public function __sleep()
    {
        return array_keys(get_object_vars($this));
    }
}
