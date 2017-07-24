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
     * @return bool
     * @throws \Exception                if the requirements is not an array or it is an array but has no contents
     * @throws UnauthorizedHttpException if the user was not able to satisfy the provided requirements
     * and is a public user.
     * @throws AccessDeniedHttpException if the user was not able to satisfy the provided requirements
     * and is not a public user.
     **/
    public static function authorized(XDUser $user, array $requirements = array(), $blacklist = false)
    {
        $isManager = $user->isManager();
        $isCenterDirector = $user->hasAcl(ROLE_ID_CENTER_DIRECTOR);

        $found = $user->hasAcls($requirements);

        // This user is authorized iff:
        //   - the absence of the requirements was required ($blacklist=true) AND the requirements were not found
        //   - the presence of the requirements was required ($blacklist=false) AND the requirements were found.
        $authorized = (!$found && $blacklist) || ($found && !$blacklist);

        if (in_array(STATUS_MANAGER_ROLE, $requirements) && !$isManager) {
            throw new AccessDeniedHttpException(self::_MESSAGE . "\n[ Not a Manager ]");
        } elseif (in_array(STATUS_CENTER_DIRECTOR_ROLE, $requirements) && $isCenterDirector === true) {
            throw new AccessDeniedHttpException(self::_MESSAGE . "\n [ Not a Center Director ]");
        } elseif($authorized === false) {
            if ($user->isPublicUser()) {
                throw new UnauthorizedHttpException('xdmod', self::_MESSAGE . " [ Not Authorized ]"); // 401 from framework
            }
            throw new AccessDeniedHttpException(self::_MESSAGE . " [ Not Authorized ]"); // 403 from framework
        }

        return true;
    }
}