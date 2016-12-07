-- =============================================================================
-- NAME:      acl_hierarchies.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides the initial 'acl_hierarchy' data that is required by this
--            module.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.acl_hierarchies (acl_id, hierarchy_id, level, filter_override)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id          acl_id,
           h.hierarchy_id AS hierarchy_id,
           0              AS level,
           1              AS filter_override
         FROM ${DESTINATION_SCHEMA}.acls a, ${DESTINATION_SCHEMA}.hierarchies h
         WHERE a.name = 'usr'
               AND h.name = 'acl_hierarchy') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.acl_hierarchies cur
      ON cur.acl_id = inc.acl_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
         AND cur.filter_override = inc.filter_override
  WHERE cur.acl_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.acl_hierarchies (acl_id, hierarchy_id, level, filter_override)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id          acl_id,
           h.hierarchy_id AS hierarchy_id,
           1              AS level,
           1              AS filter_override
         FROM ${DESTINATION_SCHEMA}.acls a, ${DESTINATION_SCHEMA}.hierarchies h
         WHERE a.name = 'po'
               AND h.name = 'acl_hierarchy') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.acl_hierarchies cur
      ON cur.acl_id = inc.acl_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
         AND cur.filter_override = inc.filter_override
  WHERE cur.acl_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.acl_hierarchies (acl_id, hierarchy_id, level, filter_override)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id          acl_id,
           h.hierarchy_id AS hierarchy_id,
           2              AS level,
           1              AS filter_override
         FROM ${DESTINATION_SCHEMA}.acls a, ${DESTINATION_SCHEMA}.hierarchies h
         WHERE a.name = 'cs'
               AND h.name = 'acl_hierarchy') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.acl_hierarchies cur
      ON cur.acl_id = inc.acl_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
         AND cur.filter_override = inc.filter_override
  WHERE cur.acl_hierarchy_id IS NULL;
