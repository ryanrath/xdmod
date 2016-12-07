-- =============================================================================
-- NAME:      statistics_hierarchy.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides initial population of the 'statistics_hiearchy' table.
--            This file was generated manually based on the sorting requirements
--            of the statistics.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           0              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'job_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           1              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'gateway_job_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           2              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'running_job_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           3              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'started_job_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           4              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'submitted_job_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           5              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'active_person_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           6              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'active_pi_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           7              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'active_allocation_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           8              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'active_institution_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           9              AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_su') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           10             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_nu') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           11             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_cpu_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           12             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_node_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           13             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_waitduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           14             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'total_wallduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           15             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_su') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           16             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_su') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           17             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_nu') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           18             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_nu') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           19             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_cpu_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           20             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_cpu_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           21             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_node_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           22             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_node_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           23             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_waitduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           24             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_waitduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           25             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_wallduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           26             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_wallduration_hours') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           27             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_processors') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           28             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'sem_avg_processors') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           29             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'min_processors') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           30             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'max_processors') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           31             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'utilization') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           32             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'expansion_factor') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           33             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'normalized_avg_processors') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           34             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'avg_job_size_weighted_by_xd_su') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           35             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'active_resource_count') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.statistics_hierarchy (statistic_id, hierarchy_id, level)
  SELECT inc.*
  FROM (
         SELECT
           s.statistic_id AS statistic_id,
           2              AS hierarchy_id,
           36             AS level
         FROM ${DESTINATION_SCHEMA}.statistics s
         WHERE s.name = 'rate_of_usage') inc
    LEFT JOIN ${DESTINATION_SCHEMA}.statistics_hierarchy cur
      ON cur.statistic_id = inc.statistic_id
         AND cur.hierarchy_id = inc.hierarchy_id
         AND cur.level = inc.level
  WHERE cur.statistic_hierarchy_id IS NULL;
