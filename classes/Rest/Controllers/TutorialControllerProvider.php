<?php

namespace Rest\Controllers;

use Configuration\XdmodConfiguration;
use Silex\Application;
use Silex\ControllerCollection;
use Symfony\Component\HttpFoundation\Request;

class TutorialControllerProvider extends BaseControllerProvider
{

    /**
     * This function is responsible for the setting up of any routes that this
     * ControllerProvider is going to be managing. It *must* be overridden by
     * a child class.
     *
     * @param Application $app
     * @param ControllerCollection $controller
     */
    public function setupRoutes(Application $app, ControllerCollection $controller)
    {
        $root = $this->prefix;
        $base = get_class($this);

        $controller->get("$root/", "$base::listTutorials");
        $controller->get("$root", "$base::listTutorials");

        $controller->get("$root/{group}", "$base::getTutorialByGroup")
            ->assert('group', '\w+|-|_');

        $controller->get("$root/{group}/{tutorial}", "$base::getTutorialByGroupAndName")
            ->assert('group', '\w+|-|_')
            ->assert('tutorial', '\w+|-|_');

    }

    public function listTutorials(Request $request, Application $app)
    {
        return $app->json(
            array(
                $this->findTutorials()
            )
        );
    }

    public function getTutorialByGroup(Request $request, Application $app, $group)
    {
        return $app->json(
            array(
                $this->findTutorials($group)
            )
        );
    }

    public function getTutorialByGroupAndName(Request $request, Application $app, $group, $tutorial)
    {
        return $app->json(
            array(
                $this->findTutorials($group, $tutorial)
            )
        );
    }

    private function findTutorials($group = null, $tutorial = null)
    {
        $config = XdmodConfiguration::assocArrayFactory('tutorials.json', CONFIG_DIR);

        if ($group === null && $tutorial === null) {
            return $config;
        } elseif ($group !== null && $tutorial !== null && array_key_exists($group, $config) && array_key_exists($tutorial, $config[$group])) {
            return $config[$group][$tutorial];
        } elseif ($group !== null && array_key_exists($group, $config)) {
            return $config[$group];
        }
        return array();
    }
}
