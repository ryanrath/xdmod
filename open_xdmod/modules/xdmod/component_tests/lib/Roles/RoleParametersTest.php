<?php

namespace ComponentTests\Roles;

use CCR\Json;
use ComponentTests\BaseTest;
use Models\Services\Parameters;
use Models\Services\Users;
use TestHarness\UserHelper;
use User\aRole;
use XDUser;

class RoleParametersTest extends BaseTest
{

    /**
     * Test that the results of aRole::getParameters === Parameters::getParameters
     * NOTES:
     *   - For any given user, aRole::getParameters will only ever be called on their currently
     *     assigned roles.
     *   - this means, for these users / role combinations, we would expect
     *     aRole::getParameters === Parameters::getParameters.
     *     - Ex. The user 'centerdirector' has the roles: 'cd', 'usr'. We would expect the that the
     *           test cases for centerdirector/CenterDirector && centerdirector/User to have
     *           identical output. But we would not expect the same for
     *           centerdirector/PrincipalInvestigator
     *    - These users only have at most, two acls per user. The 'usr' acl ( to provide default
     *      data filtering ), and possibly one more to differentiate it from the other users. So we
     *      don't run into the 'multiple center related acls' problem that the dynamic user test
     *      does.
     * @dataProvider provideGetParametersForExistingUsers
     *
     * @param array $options that drive the processing / interpretation of the test instances.
     *
     * @throws \Exception if unable to retrieve the user identified by $username.
     */
    public function testGetParametersForExistingUsers(array $options)
    {
        $username = $options['username'];
        $roleClass = $options['class'];

        // Ensure that we retrieve the correct user.
        if ($username !== 'pub') {
            $user = XDUser::getUserByUserName($username);
        } else {
            $user = XDUser::getPublicUser();
        }

        // Setup the provided role class for execution of the getParameters function.
        $role = aRole::factory($roleClass);
        $role->configure($user);

        // `$role->getParameters` is the expected output as it's the current way of doing things
        $expected = $role->getParameters();

        // `Parameters::getParameters` is the actual output as it's the proposed way of doing things
        $actual = Parameters::getParameters($user, $role->getIdentifier());

        $expectedOptions = $options['expected'];

        // if we only have a 'file' then both expected / actual should match the file and each other.
        if (array_key_exists('file', $expectedOptions)) {
            $expectedContents = JSON::loadFile($this->getTestFiles()->getFile('roles', $expectedOptions['file']));
            $actualContents = $expectedContents;
            $testEquality = true;
        } else {
            // The expected / actual may differ due to Parameters::getParameters not caring which
            // role a user has that requires extra filtering. If the role calls for filtering by a
            // particular property then it's going to return that property / value.
            $expectedContents = JSON::loadFile($this->getTestFiles()->getFile('roles', $expectedOptions['expected']));
            $actualContents = JSON::loadFile($this->getTestFiles()->getFile('roles', $expectedOptions['actual']));
            $testEquality = false;
        }

        // This is here for debugging purposes only
        /*$this->debug($expected, $expectedContents, $actual, $actualContents, $username, $roleClass, $user, $testEquality);*/

        // Check that the output for $role->getParameters matches the expected output.
        $this->assertEquals(
            $expectedContents,
            $expected,
            sprintf(
                "\n[%s] Failed asserting role->getParameters matches expected.\nExpected: %s\nActual: %s",
                $roleClass,
                json_encode($expectedContents),
                json_encode($expected)
            )
        );

        // Check that the output for Parameters::getParameters matches the expected output
        $this->assertEquals(
            $actualContents,
            $actual,
            sprintf(
                "\n[%s] Failed asserting Parameters::getParameters matches expected.\nExpected: %s\nActual: %s",
                $roleClass,
                json_encode($actualContents),
                json_encode($actual)
            )
        );

        // If the output of both functions are meant to be the same then directly compare them.
        if ($testEquality) {
            $this->assertEquals(
                $expected,
                $actual,
                sprintf(
                    "\n[%s] Failed asserting that role->getParameters === Parameters::getParameters.\nExpected: %s\nActual: %s",
                    $roleClass,
                    json_encode($expected),
                    json_encode($actual)
                )
            );
        }
    }

    /**
     * Provides the test options for RoleParametersTest::testGetParameters
     *
     * @return array|object the json data contained within the input file.
     * @throws \Exception if unable to load or parse the test file successfully
     */
    public function provideGetParametersForExistingUsers()
    {
        return Json::loadFile(
            $this->getTestFiles()->getFile('roles', 'get_parameters_base', 'input')
        );
    }

    /**
     * Test that the output of Parameters::getParameters === role->getParameters where:
     *   - The role is one that requires a center && that role is the users most privileged
     *   - The role is not one that requires a center && the user has been granted that role.
     *
     * @dataProvider provideGetParametersForDynamicUsers
     * @param array $options $options that drive the processing / interpretation of the test instances.
     * @throws \Exception
     */
    public function testGetParametersForDynamicUsers(array $options)
    {
        $username = $options['username'];
        $firstName = $options['first_name'];
        $middleName = $options['middle_name'];
        $lastName = $options['last_name'];
        $acls = $options['acls'];
        $primaryAcl = $options['primary_role'];
        $roleClasses = $options['role_classes'];
        $organizationId = isset($options['organization_id']) ? $options['organization_id'] : null;
        $personId = isset($options['person_id']) ? $options['person_id'] : null;

        // note: the order here is important due to the way that setting a users
        // organization works. The last one in wins, which needs to be the most privileged overall.
        $centerAcls = array_intersect(array('cs', 'cd'), $acls);

        // We declare $user here so that we can get at it in the catch blocks.
        $user = null;

        // User creation / setup try.
        try {
            $user = UserHelper::getUser(
                $username,
                null,
                $firstName,
                $middleName,
                $lastName,
                $acls,
                $primaryAcl,
                null,
                $organizationId,
                $personId
            );

            // Every user needs a user type
            $user->setUserType(DEMO_USER_TYPE);

            $user->saveUser();

            // set the organizations if necessary
            foreach ($centerAcls as $centerAcl) {
                if (isset($organizationId)) {
                    $user->setOrganizations(
                        array($organizationId => array('active' => 1, 'primary' => 1)),
                        $centerAcl
                    );
                }
            }
        } catch (\Exception $e) {
            echo sprintf(
                "\n-=-=-=-=-=-=-=-=-=-=-=-=-\n[%s] %s\n%s",
                $e->getCode(),
                $e->getMessage(),
                $e->getTraceAsString()
            );
            if (isset($user)) {
                try {
                    $user->removeUser();
                } catch (\Exception $e) {
                    echo sprintf(
                        "\nUnable to remove user after exception [%s]. Please remove manually\n",
                        $username
                    );
                }
            }
        } // try { user creation / setup }

        // Here is the actual meat of the test. Note this code needs to be out of the user creation
        // try so that if an equality test fails, the exception will actually be propagated
        // correctly.
        foreach ($roleClasses as $roleClass) {
            // Setup the provided role class for execution of the getParameters function.
            $role = aRole::factory($roleClass);
            $role->configure($user);
            $roleId = $role->getIdentifier();

            // `$role->getParameters` is the expected output as it's the current way of doing things
            $expected = $role->getParameters();

            // `Parameters::getParameters` is the actual output as it's the proposed way of doing things
            $actual = Parameters::getParameters($user, $roleId);

            /* we can only test for equality in the following cases:
             *    - If the $role is one of the center roles ('cd', 'cs') and it is also this users
             *      most privileged role.
             *    - If the $role is not a center role && it is a role that is currently assigned to
             *      this user.
             * NOTES:
             *    - Here is a quick breakdown of why we can only test equality for center roles
             *      that are a users most privileged role.
             *
             *      So if we start with the following state (post user creation):
             *          - User: test1
             *          - Roles: cd (most privileged), cs
             *          - Center: 1
             *          - DB records:
             *              - user: test1, role: cs, is_active: false, value: center 1
             *              - user: test1, role: cd, is_active: true,  value: center 1
             *
             *      Create / configure a CenterStaff role object for this user.
             *
             *      During `configure` the role queries the DB for records matching:
             *      user: test1, role: cs, is_active: true
             *
             *      No records match this criteria so calls to `getParameters` will return an empty
             *      array.
             *    - We also cannot test for equality with roles the user has not been assigned
             *      because the existing code doesn't do this and frankly it doesn't make sense.
             */
            if (
                (in_array($roleId, $centerAcls)  && $roleId === $primaryAcl) ||
                (!in_array($roleId, $centerAcls) && in_array($roleId, $acls))
            ) {
                // again, just for debugging
                /*$this->debug($expected, $expected, $actual, $actual, $username, $roleClass, $user, true);*/
                $this->assertEquals(
                    $expected,
                    $actual,
                    "Expected that the output from role->getParameters would match the output from Parameters::getParameters"
                );
            }
        } // foreach ($roleClasses as $roleClass)

        // Make sure to remove the test user when we're done
        if (isset($user)) {
            $user->removeUser();
        }
    }

    /**
     * Provides a dynamically generated set of test cases for the testGetParametersForDynamicUsers
     *
     * @return array
     * @throws \Exception
     */
    public function provideGetParametersForDynamicUsers()
    {
        /**
         * Generates all combinations of the elements contained within $data.
         *
         * @param array $data
         * @return array
         */
        function allCombinations(array $data)
        {
            $results = array(array());
            foreach ($data as $element) {
                foreach ($results as $combination) {
                    array_push($results, array_merge(array($element), $combination));
                }
            }
            return $results;
        }

        /**
         * Provides the 'Most Privileged' acl contained within $userAcls.
         * It is required that $acls be ordered most privileged -> least privileged for this
         * function to work properly
         *
         * @param array $acls
         * @param array $userAcls
         * @return mixed|null
         */
        function mostPrivileged(array $acls, array $userAcls)
        {
            $intersection = array_intersect($acls, $userAcls);
            $first = array_shift($intersection);
            return isset($first) ? $first : null;
        }

        // retrieve the options that will drive the input generation.
        $inputOptions = JSON::loadFile(
            $this->getTestFiles()->getFile(
                'roles',
                'get_parameters_dynamic',
                'input'
            )
        );

        // All current role classes
        $classes = $inputOptions['classes'];

        // person mappings based on most privileged acl.
        $aclPersons = $inputOptions['acl_persons'];

        // All current acls
        $baseAcls = $inputOptions['acls'];

        // Acls that are of the 'feature' type.
        $featureAcls = $inputOptions['feature_acls'];

        // Acls that require a user to have an associated center.
        $aclsThatRequireCenter = $inputOptions['center_acls'];

        $aclsThatRequirePerson = array_diff($baseAcls, $featureAcls);

        // generate all possible combos of our current set of acls.
        // NOTE: the array_filter just makes sure that we don't include empty arrays.
        $aclCombos = array_values(
            array_filter(
                allCombinations($baseAcls),
                function (array $value) {
                    return count($value) > 0;
                }
            )
        );

        $testCases = array();

        foreach ($aclCombos as $acls) {

            // Make sure we skip any combo that is made up entirely of these feature acls as they
            // do not provide any data filtering.
            $skip = count(array_intersect($featureAcls, $acls)) >= count($acls);

            if (!$skip) {
                $aclId = implode('_', $acls);
                $username = "user-$aclId";
                $mostPrivileged = mostPrivileged($baseAcls, $acls);
                $needsOrganization = count(array_intersect($aclsThatRequireCenter, $acls)) > 0;
                $needsPerson = count(array_intersect($aclsThatRequirePerson, $acls)) > 0;

                $testCase = array(
                    'username' => $username,
                    'first_name' => 'A',
                    'middle_name' => 'Test',
                    'last_name' => "User - $aclId",
                    'acls' => $acls,
                    'primary_role' => $mostPrivileged,
                    'role_classes' => $classes
                );

                if ($needsOrganization) {
                    $testCase['organization_id'] = 1;
                }

                if ($needsPerson) {
                    $testCase['person_id'] = $aclPersons[$mostPrivileged];
                }

                $testCases[] = array($testCase);
            }
        }
        return $testCases;
    }


    /**
     * A helper function that logs useful debug information.
     *
     * @param array   $expected
     * @param array   $expectedContents
     * @param array   $actual
     * @param array   $actualContents
     * @param string  $username
     * @param string  $roleClass
     * @param \XDUser $user
     * @param boolean $testEquality
     */
    protected function debug(array $expected, array $expectedContents, array $actual, array $actualContents, $username, $roleClass, \XDUser $user, $testEquality)
    {
        $piId = Users::isPrincipalInvestigator($user) ? $user->getPersonID() : -1;
        $expectedEquals = $expected === $expectedContents;
        $actualEquals = $actual === $actualContents;
        $equals = $actual === $expected;

        echo sprintf(
            implode(
                "\n",
                array(
                    "\nUser: $username Role: $roleClass",
                    "",
                    "\t{ organization_id: %s, person_id: %s, pi_id: %s }",
                    "",
                    "\t\$role->getParameters:              %s",
                    "\tParameters::getParameters:         %s",
                    "",
                    "\tExpected \$role->getParameters:     %s",
                    "\tExpected Parameters::getParamters: %s",
                    "",
                    "\t\$role->getParameters equals:        %s",
                    "\tParameters::getParameters equals:   %s",
                    "",
                    "\tTesting for equality: %s",
                    "\tActual == Expected:   %s",
                    "***********************************************************"
                )
            ),
            $user->getOrganizationID(),
            $user->getPersonID(),
            $piId,
            json_encode($expected),
            json_encode($actual),
            json_encode($expectedContents),
            json_encode($actualContents),
            $expectedEquals ? 'true' : 'false',
            $actualEquals ? 'true' : 'false',
            $testEquality ? 'true' : 'false',
            $equals ? 'true' : 'false'
        );
    }
}