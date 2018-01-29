<?php namespace Models\Services;

use Exception;
use PDO;

use CCR\DB;
use CCR\DB\iDatabase;
use Models\Acl;
use Models\GroupBy;
use Models\Realm;
use Models\Statistic;
use XDUser;

/**
 * Class Centers
 * @package User
 *
 * It is the intended purpose of this class to provide a host of functions to
 * ease working with and within the Acl framework. It provides basic CRUD
 * functionality in addition to a number of other functions related to Acls and
 * their associated pieces of data.
 *
 */
class Centers
{

    public static function getCenters()
    {
        $db = DB::factory('database');

        return $db->query("SELECT o.* FROM modw.organization o");
    }

    public static function getCenterStaffMembers(XDUser $user)
    {
        $userId = $user->getUserID();
        if ($userId === '0') {
            throw new Exception('User must be saved before retrieving center staff members.');
        }

        $query = <<< SQL
SELECT DISTINCT
  u.id,
  CONCAT(u.last_name, ', ', u.first_name, ' [', o.abbrev, ']') as name
FROM user_acl_group_by_parameters uagbp
  JOIN Users u ON u.id = uagbp.user_id
  JOIN acls a ON uagbp.acl_id = a.acl_id
  JOIN group_bys gb ON uagbp.group_by_id = gb.group_by_id
  JOIN (
    SELECT DISTINCT
      uagbp.value
    FROM user_acl_group_by_parameters uagbp
      JOIN group_bys gb ON uagbp.group_by_id = gb.group_by_id
      JOIN acls a ON uagbp.acl_id = a.acl_id
    WHERE
      gb.name = 'provider' AND
      a.name = 'cd' AND
      uagbp.user_id = :user_id
    ) cdo ON uagbp.value = cdo.value
  LEFT JOIN modw.organization o ON o.id = uagbp.value  
WHERE a.name = 'cs'
SQL;
        $params = array(':user_id' => $userId);

        $db = DB::factory('database');

        return $db->query($query, $params);
    }

    public static function getCenterMembers($centerId)
    {
        $multipleServiceProviders = \xd_utilities\getConfiguration('features', 'multiple_service_providers') === 'on';

        if ($multipleServiceProviders) {
            $query = <<<SQL
SELECT DISTINCT
  u.id,
  CONCAT(u.last_name, ', ', u.first_name, ' [', o.abbrev, ']') as name
FROM user_acl_group_by_parameters uagbp
  JOIN Users u ON u.id = uagbp.user_id
  JOIN acls a ON uagbp.acl_id = a.acl_id
  JOIN group_bys gb ON uagbp.group_by_id = gb.group_by_id
  JOIN modw.organization o ON o.id = uagbp.value
WHERE
  a.name != 'cd' AND
  uagbp.value = :center_id;
SQL;
            $params = array(':center_id' => $centerId);
        } else {
            $query = <<<SQL
SELECT DISTINCT
  u.id,
  CONCAT(u.last_name, ', ', u.first_name, ' [', o.abbrev, ']') as name
FROM user_acls ua
  JOIN Users u ON u.id = ua.user_id
  JOIN acls a ON ua.acl_id = a.acl_id
  LEFT JOIN (
    SELECT
      ua.user_id
    FROM user_acls ua
    JOIN acls a ON ua.acl_id = a.acl_id
    WHERE a.name IN ('cd', 'cs', 'pub')
  ) rem ON ua.user_id = rem.user_id
  LEFT JOIN modw.organization o ON o.id = :centerId
WHERE
  rem.user_id IS NULL;
SQL;
            $params = array();
        }

        $db = DB::factory('database');

        return $db->query($query, $params);
    }
}
