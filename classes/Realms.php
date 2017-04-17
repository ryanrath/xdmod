<?php

use CCR\DB;
use CCR\DB\iDatabase;

/**
 * Class Realms
 *
 * This class attempts to provide any and all required functions for working
 * with the table 'realms' and it's relations.
 *
 * It provides basic CRUD functionality ( Create, Read, Update, Delete ) as well as a number of methods
 * of retrieving Realms via associated information i.e.
 *   - List all realms created by a particular module ( listRealmsFor[Module|ModuleName|ModuleId] )
 *   - List all realms that a user has access to via their assigned ACLS ( listRealmsForUserId )
 */
class Realms
{
    /**
     * @return array|Realm[]
     */
    public static function listRealms()
    {
        return self::_listRealms(
            DB::factory('database')
        );
    }

    public static function listRealmsForModule(Module $module)
    {
        if (null === $module) {
            throw new Exception('A valid module is required.');
        }
        $moduleId = $module->getModuleId();
        if (null === $moduleId) {
            throw new Exception('A valid module id is required.');
        }
        return self::listRealmsForModuleId($moduleId);
    }

    public static function listRealmsForModuleName($moduleName)
    {
        if (null === $moduleName) {
            throw new Exception('A valid module name is required.');
        }
        return self::_listRealmsForModuleName(
            DB::factory('database'),
            $moduleName
        );
    }

    public static function listRealmsForModuleId($moduleId)
    {
        if (null === $moduleId) {
            throw new Exception('A valid module id is required.');
        }

        return self::_listRealmsForModuleId(
            DB::factory('database'),
            $moduleId
        );
    }

    /**
     * @param integer $userId
     * @return Realm[]|array()
     * @throws Exception
     */
    public static function listRealmsForUserId($userId)
    {
        if (null === $userId) {
            throw new Exception('A valid user id is required.');
        }

        return self::_listRealmsForUserId(
            DB::factory('database'),
            $userId
        );
    }

    /**
     * @param string $name
     * @return null|Realm
     * @throws Exception
     */
    public static function getRealmByName($name)
    {
        if (null === $name) {
            throw new Exception('Valid realm name required.');
        }
        if (!is_string($name)) {
            throw new Exception('Valid realm name required. (string)');
        }
        if (strlen($name) < 1) {
            throw new Exception('Valid realm name required. (length)');
        }
        return self::_getRealmByName(
            DB::factory('database'),
            $name
        );
    }

    public static function getRealmById($realmId)
    {
        if (null === $realmId) {
            throw new Exception('Valid realm id required.');
        }
        if (!is_numeric($realmId)) {
            throw new Exception('Valid realm id required. (number)');
        }
        return self::_getRealmById(
            DB::factory('database'),
            $realmId
        );
    }

    public static function getRealmsByModule(Module $module)
    {
        if (null === $module) {
            throw new Exception('a valid module is required.');
        }
        $moduleId = $module->getModuleId();
        if (null === $moduleId) {
            throw new Exception('A valid module is required. (id)');
        }
        return self::getRealmsByModuleId(
            $moduleId
        );
    }

    public static function getRealmsByModuleId($moduleId)
    {
        if (null === $moduleId) {
            throw new Exception('A valid module id is required.');
        }
        return self::_getRealmsByModuleId(
            DB::factory('database'),
            $moduleId
        );
    }

    public static function updateRealm(Realm $realm)
    {
        if (null === $realm) {
            throw new Exception('A valid realm is required');
        }
        $realmId = $realm->getRealmId();
        if (null === $realmId) {
            throw new Exception('A valid realm id is required');
        }
        return self::_updateRealm(
            DB::factory('database'),
            $realm
        );
    }

    public static function deleteRealm(Realm $realm)
    {
        if (null === $realm) {
            throw new Exception('A valid realm is required');
        }
        $realmId = $realm->getRealmId();
        if (null === $realmId) {
            throw new Exception('A valid realm id is required');
        }
        return self::_deleteRealm(
            DB::factory('database'),
            $realmId
        );
    }

    /**
     * @param iDatabase $db
     *
     * @return Realm[]|array
     */
    private static function _listRealms(iDatabase $db)
    {
        $query = <<<SQL
SELECT r.*
FROM realms r
SQL;
        $rows = $db->query($query);
        if ( count($rows) > 0 ) {
            return array_reduce($rows, function ($carry, $item) {
                $carry [] = new Realm($item);
                return $carry;
            }, array());
        }
        return array();
    }

    /**
     * @param iDatabase $db
     * @param string $name
     * @return null|Realm
     */
    private static function _getRealmByName(iDatabase $db, $name)
    {
        $query = <<<SQL
SELECT r.* 
FROM realms r 
WHERE r.name = :realm_name
SQL;
        $rows = $db->query($query, array(
            ':realm_name' => $name
        ));
        if ( count($rows) > 0 ) {
            return new Realm($rows[0]);
        }
        return null;
    }

    private static function _getRealmById(iDatabase $db, $realmId)
    {
        $query = <<<SQL
SELECT r.* 
FROM realms r 
WHERE r.realm_id = :realm_id
SQL;

        $rows = $db->query($query, array(
            'realm_id' => $realmId
        ));
        if ( count($rows) > 0 ) {
            return new Realm($rows[0]);
        }
        return null;
    }

    /**
     * @param iDatabase $db
     * @param $moduleId
     * @return Realm[]|array()
     */
    private static function _getRealmsByModuleId(iDatabase $db, $moduleId)
    {
        $query = <<<SQL
SELECT r.*
FROM realms r 
WHERE r.module_id = :module_id
SQL;
        $rows = $db->query($query, array(
            ':module_id' => $moduleId
        ));
        if ( count($rows) > 0 ) {
            return array_reduce($rows, function ($carry, $item) {
                $carry [] = new Realm($item);
                return $carry;
            }, array());
        }
        return array();
    }

    private static function _updateRealm(iDatabase $db, Realm $realm)
    {
        $query = <<<SQL
UPDATE realms SET
  module_id = :module_id,
  name = :name,
  display = :display, 
  table_name = :table_name,
  schema_name = :schema_name
WHERE 
  realm_id = :realm_id
SQL;
        $rowCount = $db->execute($query, array(
            ':module_id' => $realm->getModuleId(),
            ':name' => $realm->getName(),
            ':display' => $realm->getDisplay(),
            ':table_name' => $realm->getTableName(),
            ':schema_name' => $realm->getSchemaName(),
            ':realm_id' => $realm->getRealmId()
        ));
        return $rowCount > 0;
    }

    private static function _deleteRealm(iDatabase $db, $realmId)
    {
        $query = <<<SQL
DELETE FROM realms WHERE realm_id = :realm_id;
SQL;
        $rowCount = $db->execute($query, array(
            ':realm_id' => $realmId
        ));
        return $rowCount > 0;
    }

    private static function _listRealmsForModuleId(iDatabase $db, $moduleId)
    {
        $query = <<<SQL
SELECT r.*
FROM realms r 
WHERE r.module_id = :module_id 
SQL;
        $rows = $db->query($query, array(
            ':module_id' => $moduleId
        ));
        if ( count($rows) > 0 ) {
            return array_reduce($rows, function ($carry, $item) {
                $carry []= new Realm($item);
                return $carry;
            }, array());
        }
        return array();
    }

    private static function _listRealmsForModuleName(iDatabase $db, $moduleName)
    {
        $query = <<<SQL
SELECT r.* 
FROM realms r 
JOIN modules m 
ON r.module_id = m.module_id 
WHERE m.name = :module_name
SQL;
        $rows = $db->query($query, array(
            ':module_name' => $moduleName
        ));
        if ( count($rows) > 0 ) {
            return array_reduce($rows, function ($carry, $item) {
                $carry []= new Realm($item);
                return $carry;
            }, array());
        }
        return array();
    }

    /**
     * @param iDatabase $db
     * @param integer $userId
     * @return array|mixed
     */
    private static function _listRealmsForUserId(iDatabase $db, $userId)
    {
        $query = <<<SQL
SELECT DISTINCT
  r.*
FROM realms r
  JOIN group_bys gb ON r.realm_id = gb.realm_id
  JOIN acl_group_bys agb ON gb.group_by_id = agb.group_by_id
  JOIN user_acls ua ON agb.acl_id = ua.acl_id
WHERE ua.user_id = :user_id
SQL;
        $rows = $db->query($query, array(
            ':user_id' => $userId
        ));
        if ( count($rows) > 0 ) {
            return array_reduce($rows, function ($carry, $item) {
                $carry []= new Realm($item);
                return $carry;
            }, array());
        }
        return array();
    }
}
