<?php

namespace NewRest\Utilities;

use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\UnauthorizedHttpException;
use XDUser;

class Authorization
{

    const _DEFAULT_SESSION_KEY = 'xdUser';
    const _SUCCESS = 0;
    const _MESSAGE = 1;

    const _DEFAULT_MESSAGE = 'An error was encountered while attempting to process the requested authorization procedure.';

    /**
     * This function attempts to determine whether or not the provided $user
     * has the provided $requirements. If $blacklist is supplied then success
     * will be whether or not the user *does not* have the provided requirements.
     *
     * @param XDUser $user the user to authorize
     * @param array $requirements an array of acl names
     * @param bool $blacklist whether or not to test for the presence of the $requirements or the absence
     * @return array
     * @throws \Exception                if the requirements is not an array or it is an array but has no contents
     * @throws UnauthorizedHttpException if the user was not able to satisfy the provided requirements
     * and is a public user.
     * @throws AccessDeniedHttpException if the user was not able to satisfy the provided requirements
     * and is not a public user.
     **/
    public static function authorized(XDUser $user, array $requirements = array(), $blacklist = false)
    {
        $result = array(
            self::_SUCCESS => false,
            self::_MESSAGE => self::_DEFAULT_MESSAGE
        );

        $requirements = self::_preProcessRequirements($user, $requirements);

        $roles = $user->getRoles();
        $isManager = $user->isManager();
        $activeRole = $user->getActiveRole()->getIdentifier();

        if (in_array(SAB_MEMBER, $requirements) && !in_array('sab', $roles)) {
            $result[self::_MESSAGE] = self::_DEFAULT_MESSAGE . "\n[ Not a SAB Member ]";
        } else if (in_array(STATUS_MANAGER_ROLE, $requirements) && !$isManager) {
            $result[self::_MESSAGE] = self::_DEFAULT_MESSAGE . "\n[ Not a Manager ]";
        } else if (in_array(STATUS_CENTER_DIRECTOR_ROLE, $requirements) && $activeRole !== ROLE_ID_CENTER_DIRECTOR) {
            $result[self::_MESSAGE] = self::_DEFAULT_MESSAGE . "\n [ Not a Center Director ]";
        } else {
            if (!$blacklist) {
                $found = 0;
                foreach ($requirements as $requirement) {
                    if (in_array($requirement, $roles)) $found += 1;
                }
                if ($found >= count($requirements)) {
                    $result[self::_SUCCESS] = true;
                    $result[self::_MESSAGE] = '';
                } else {
                    $result[self::_MESSAGE] .= " [ Not Authorized ]";
                }
            } else {
                $found = 0;
                foreach($requirements as $requirement) {
                    if (in_array($requirement, $roles)) $found += 1;
                }
                if ($found === 0) {
                    $result[self::_SUCCESS] = true;
                    $result[self::_MESSAGE] = '';
                } else {
                    $result[self::_MESSAGE] .= " [ Not Authorized ]";
                }
            }

        }

        return $result;
    }

    /**
     * Conduct any processing on the provided requirements prior to the actual
     * authorization process.
     *
     * @param XDUser $user object that represents the currently logged in user.
     * @param array $requirements that the user must fulfill to be considered 'authorized'.
     * @return array of $requirements.
     */
    private static function _preProcessRequirements(XDUser $user, array $requirements)
    {

        if ($user->isManager()) {
            \xd_utilities\remove_element_by_value($requirements, SAB_MEMBER);
        }

        return $requirements;
    }


}