-- =============================================================================
-- NAME:      realms.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides the initial 'realms' that this module supports.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.realms (module_id, name, display, table_name, schema_name)
  SELECT inc.*
  FROM (
         SELECT
           m.module_id       AS module_id,
           'jobs'            AS name,
           'Jobs'            AS display,
           'jobfact'         AS table_name,
           'modw_aggregates' AS schema_name
         FROM ${DESTINATION_SCHEMA}.modules m
         WHERE m.name = 'xdmod') inc LEFT JOIN ${DESTINATION_SCHEMA}.realms cur
      ON cur.module_id = inc.module_id AND cur.name = inc.name AND
         cur.display = inc.display AND cur.table_name = inc.table_name AND
         cur.schema_name = inc.schema_name
  WHERE cur.realm_id IS NULL;