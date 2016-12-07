-- =============================================================================
-- NAME:      acl_group_bys.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provide initial population of the acl_group_bys ( these were
--            previously known as query descripters). This file was created by
--            capturing the output of `query_descripters.py path/to/roles.json`.
--            This script was executed for roles.json and for every file in
--            roles.d. Currently the script resides in a separate tool project
--            but will be incorporated shortly.
-- =============================================================================

INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           False             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pub'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cd'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'mgr'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'usr'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'pi'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'po'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'none') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'allocation') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'fieldofscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'gateway') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'grant_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'jobsize') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'jobwalltime') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'nodecount') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'nsfdirectorate') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'parentscience') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'pi') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'pi_institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'queue') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'resource') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'resource_type') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'provider') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'username') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'person') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'institution') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;



INSERT INTO acl_group_bys (acl_id, realm_id, group_by_id, statistic_id, visible, enabled)
  SELECT inc.*
  FROM (
         SELECT
           a.acl_id       AS acl_id,
           r.realm_id     AS realm_id,
           gb.group_by_id AS group_by_id,
           s.statistic_id AS statistic_id,
           True             AS visible,
           True             AS enabled
         FROM statistics s, realms r,
           acls a, group_bys gb
         WHERE
           s.realm_id = r.realm_id
           AND gb.realm_id = r.realm_id
           AND r.name = LOWER('Jobs')
           AND a.name = 'cc'
           AND gb.name = 'nsfstatus') inc
    LEFT JOIN acl_group_bys cur
      ON cur.acl_id = inc.acl_id
         AND cur.realm_id = inc.realm_id
         AND cur.group_by_id = inc.group_by_id
         AND cur.statistic_id = inc.statistic_id
  WHERE
    cur.acl_group_by_id IS NULL;