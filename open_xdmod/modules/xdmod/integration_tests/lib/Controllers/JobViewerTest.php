<?php

namespace IntegrationTests\Controllers;

class JobViewerTest extends \PHPUnit_Framework_TestCase
{

    protected function setUp() {
        $this->helper = new \TestHarness\XdmodTestHelper();
        $this->defaultJobSearchParams = array(
            'start_date' => '2016-12-28',
            'end_date' => '2017-01-01',
            'realm' => 'SUPREMM',
            'limit' => 24,
            'start' => 0
        );
        $this->jobSearchUrl = 'rest/v1/warehouse/search/jobs';
    }

    public function testCenterDirectorCanSeeJobsByProvider() {
        $provider = '1';
        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'provider' => array($provider)
            )
        );

        $this->helper->authenticate('cd');

        return $this->get($this->jobSearchUrl, $params, function ($data) {
            $this->assertTrue(count($data['results']) > 0);

            return $data['totalCount'];
        });
    }

    /**
     * @depends testCenterDirectorCanSeeJobsByProvider
     **/
    public function testCenterDirectorCanSeeMultipleResources($totalCount) {
        $frearson = '1';
        $robertson = '5';

        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'resource' => array($frearson, $robertson)
            )
        );

        $this->helper->authenticate('cd');

        return $this->get($this->jobSearchUrl, $params, function ($data) use ($totalCount) {
            $this->assertTrue(count($data['results']) > 0);
            $this->assertEquals($totalCount, $data['totalCount']);

            return $data['totalCount'];
        });
    }

    /**
     * @depends testCenterDirectorCanSeeMultipleResources
     **/
    public function testCenterDirectorCanSeeJobsByResource($totalCount) {
        $robertson = '5';

        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'resource' => array($robertson)
            )
        );

        $this->helper->authenticate('cd');

        return $this->get($this->jobSearchUrl, $params, function ($data) use ($totalCount) {
            $this->assertTrue(count($data['results']) > 0);

            $this->assertTrue($totalCount > $data['totalCount']);

            return $data['totalCount'];
        });
    }

    public function testPICanSeeUsersJobs() {
        $principal = '83';
        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'pi' => [$principal]
            )
        );

        $this->helper->authenticate('pi');

        $this->get($this->jobSearchUrl, $params, function ($data) {
            $this->assertTrue(count($data['results']) > 0);
        });
    }

    public function testPICannotSeeOtherPIJobs() {
        $principal = '13';
        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'pi' => [$principal]
            )
        );

        $this->helper->authenticate('pi');

        $this->get($this->jobSearchUrl, $params, function ($data) {
            $this->assertTrue(count($data['results']) === 0);
        });
    }

    public function testUsrCanSeeTheirOwnJobsByPerson() {
        $person = '60';

        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'person' => [$person]
            )
        );

        $this->helper->authenticate('pi');

        $this->get($this->jobSearchUrl, $params, function ($data) {
            $this->assertTrue(count($data['results']) === 1);
        });
    }

    /**
     * It is expected that testCenterDirectorCanSeeJobsByResource should return
     * a total number of jobs greater than 1. And it should be the case that a
     * Center Director has access to see more jobs than a user.
     *
     * @depends testCenterDirectorCanSeeJobsByResource
     **/
    public function testUserCanOnlySeeTheirOwnJobsByResource($totalCount) {
        $resource = '5';

        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'resource' => [$resource]
            )
        );

        $this->helper->authenticate('pi');

        $this->get($this->jobSearchUrl, $params, function ($data) use ($totalCount) {
            $this->assertTrue(count($data['results']) === 1);
            $this->assertTrue($totalCount > count($data['results']));
        });
    }

    public function testUserCannotSeeAnotherUsersJobs() {
        $person = '15';
        $params = $this->defaultJobSearchParams;
        $params['params'] = json_encode(
            array(
                'person' => [$person]
            )
        );

        $this->helper->authenticate('pi');

        $this->get($this->jobSearchUrl, $params, function ($data) {
            $this->assertTrue(count($data['results']) === 0);
        });
    }

    private function get($url, array $params, callable $dataValidator = null, $returnType = 'application/json', $responseCode = 200) {
        $response = $this->helper->get($url, $params);

        $this->assertEquals($response[1]['content_type'], $returnType);
        $this->assertEquals($response[1]['http_code'], $responseCode);

        $data = $response[0];

        $this->assertArrayHasKey('totalCount', $data);
        $this->assertArrayHasKey('results', $data);
        $this->assertEquals($data['totalCount'], count($data['results']));

        if ($dataValidator !== null) {
            return $dataValidator($data);
        }
    }
}
