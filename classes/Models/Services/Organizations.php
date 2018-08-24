<?php

namespace Models\Services;

use CCR\DB;

class Organizations
{

    /**
     * Retrieve the organization that the user identified by the $userId parameter is associated
     * with.
     *
     * @param int $userId the id of the user for whom an associated organization ( if any ) is to be
     *                    retrieved.
     *
     * @return int the id of the organization $userId is associated with. If one is not found then
     *             -1 is returned.
     *
     * @throws \Exception if there is a problem retrieving a db connection.
     * @throws \Exception if there is a problem executing sql statements.
     */
    public static function getOrganizationForUser($userId)
    {
        $sql = <<<SQL
    SELECT src.organization_id
    FROM (
      SELECT user_org.*
      FROM (
      SELECT
          u.organization_id,
          2
        FROM moddb.Users u
        JOIN modw.organization o ON o.id = u.organization_id
        WHERE u.id = :user_id
        UNION
        SELECT
          o.id organization_id,
          1
        FROM moddb.Users u
        JOIN modw.person p ON p.id = u.person_id
        JOIN modw.organization o ON o.id = p.organization_id
        WHERE u.id = :user_id
      ) user_org
      ORDER BY 2
      LIMIT 1
    ) src;
SQL;
        $db = DB::factory('database');

        $rows = $db->query(
            $sql,
            array(':user_id' => $userId)
        );

        return count($rows) > 0 ? $rows[0]['organization_id'] : -1;
    }

    /**
     * Retrieve the name for the organization identified by the provided id.
     *
     * @param int $organizationId the id of the organization whose name is to be retrieved.
     *
     * @return string Returns 'Unknown' if the organization could not be found, else the `name`
     *                value is returned.
     *
     * @throws \Exception if there is a problem retrieving a db connection
     * @throws \Exception if there is a problem executing sql
     */
    public static function getNameById($organizationId)
    {
        $query = <<<SQL
SELECT o.name
FROM modw.organization o
WHERE o.id = :organization_id
UNION
SELECT unk.name
FROM modw.organization unk
WHERE unk.id = -1
SQL;
        $params = array(
            ':organization_id' => $organizationId
        );

        $db = DB::factory('database');

        $rows = $db->query($query, $params);

        return $rows[0]['name'];
    }

    /**
     * Attempt to retrieve the organization id associated with the provided
     * $organizationName.
     *
     * @param string $organizationName the name of the organization to retrieve.
     * @return int|null null if no record is found else the organization_id as an int.
     * @throws \Exception if there is a problem retrieving a db connection.
     * @throws \Exception if there is a problem executing the sql statement.
     */
    public static function getIdByName($organizationName)
    {
        $db = DB::factory('database');
        $rows = $db->query(
            "SELECT o.id FROM modw.organization o WHERE o.name = :organization_name;",
            array(':organization_name' => $organizationName)
        );
        return !empty($rows) ? $rows[0]['id'] : -1;
    }

    /**
     * Attempt to retrieve the organization_id for the specified person_id.
     *
     * @param int $personId
     * @return int id of the organization or -1 if not found
     * @throws \Exception
     */
    public static function getOrganizationIdForPerson($personId)
    {
        $db = DB::factory('database');
        $rows = $db->query(
            "SELECT p.organization_id FROM modw.person p WHERE p.id = :person_id",
            array(
                ':person_id' => $personId
            )
        );

        return count($rows) > 0 ? $rows[0]['organization_id'] : -1;
    }
}
