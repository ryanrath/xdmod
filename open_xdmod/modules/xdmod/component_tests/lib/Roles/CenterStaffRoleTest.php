<?php

namespace ComponentTests\Roles;

use ComponentTests\BaseTest;
use Exception;
use User\Roles\CenterStaffRole;
use XDUser;
use CCR\Json;

/**
 * Tests meant to exercise the functions in the CenterStaffRole class
 **/
class CenterStaffRoleTest extends BaseTest
{
    public function testGetIdentifier()
    {
        $expected = self::CENTER_STAFF_ACL_NAME;
        $user = XDUser::getUserByUserName(self::CENTER_STAFF_USER_NAME);
        $cs = new CenterStaffRole();
        $cs->configure($user);
        $actual = $cs->getIdentifier();
        $this->assertEquals($expected, $actual);
    }

    /**
     * @expectedException Exception
     * @expectedExceptionMessage No user ID has been assigned to this role.  You must call configure() before calling getCorrespondingUserID()
     */
    public function testGetActiveCenterNoUser()
    {
        $cs = new CenterStaffRole();
        $cs->getActiveCenter();
    }

    /**
     * @dataProvider provideGetActiveCenter
     * @param string $userName Name of the user we are checking
     * @param int $expectedCenterId Expected center identifier (organization_id)
     */

    public function testGetActiveCenter($userName, $expectedCenterId)
    {
        $user = XDUser::getUserByUserName($userName);
        $cs = new CenterStaffRole();
        $cs->configure($user);
        $actual = $cs->getActiveCenter();
        $this->assertEquals($expectedCenterId, $actual);
    }

    public function provideGetActiveCenter()
    {
        return Json::loadFile(
            $this->getTestFiles()->getFile('roles', 'get_active_center', 'input')
        );
    }
}
