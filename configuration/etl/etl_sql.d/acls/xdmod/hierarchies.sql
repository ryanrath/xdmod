-- =============================================================================
-- NAME:      hierarchies.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provide initial population of the hierarchies table. This file was
--            generated manually based on structural requirements identified
--            earlier in the project.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.hierarchies (`module_id`, `name`, `display`)
  SELECT inc.*
  FROM (
         SELECT
           m.module_id     AS module_id,
           'acl_hierarchy' AS name,
           'ACL Hierarchy' AS display
         FROM ${DESTINATION_SCHEMA}.modules m
         WHERE m.name = 'xdmod') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.hierarchies cur
      ON
        cur.module_id = inc.module_id
        AND cur.name = inc.name
        AND cur.display = inc.display
  WHERE cur.hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.hierarchies (`module_id`, `name`, `display`)
  SELECT inc.*
  FROM (
         SELECT
           m.module_id           AS module_id,
           'statistic_hierarchy' AS name,
           'Statistic Hierarchy' AS display
         FROM ${DESTINATION_SCHEMA}.modules m
         WHERE m.name = 'xdmod') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.hierarchies cur
      ON
        cur.module_id = inc.module_id
        AND cur.name = inc.name
        AND cur.display = inc.display
  WHERE cur.hierarchy_id IS NULL;
