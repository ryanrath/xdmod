<?php

namespace Configuration;

use Exception;
use stdClass;

/**
 * Class XdmodConfiguration
 *
 * This class adds the ability for configuration files to have `extends` properties processed.
 *
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
        $this->handleExtendsFor($this->transformedConfig);
    } // processExtends

    /**
     * This function will handle the `extends` keyword for the provided $source object. This will
     * result in merging properties from the `extends` target into the object that defined the
     * `extends` property. After the processing is done the `extends` property will be removed.
     *
     * @param $source
     * @throws Exception
     */
    protected function handleExtendsFor($source)
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
     */
    protected function findExtends(\stdClass $config, $parentKey = null)
    {
        $extends = array();
        foreach ($config as $k => $v) {
            if ($k === self::EXTENDS_KEYWORD && is_string($v)) {
                $extends[$parentKey] = $v;
            } elseif (is_object($v)) {
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
    protected function resolveExtends(\stdClass &$config, array $extenders)
    {
        $extendsProperty = self::EXTENDS_KEYWORD;
        foreach ($config as $k => $v) {
            if (in_array($k, $extenders)) {
                $target = $this->findByKey($v->$extendsProperty, $config);
                if ($target === null) {
                    $this->logAndThrowException("Unable to find $extendsProperty target $v");
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
}