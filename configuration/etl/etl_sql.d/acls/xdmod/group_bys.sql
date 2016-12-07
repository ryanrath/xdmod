-- =============================================================================
-- NAME:      group_bys.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provide initial population of the group_bys table. This file was
--            created programmatically by utilizing a tool called 'parser' that
--            was written expressly for the purpose of processing existing PHP
--            files ( within a provided directory ) and extracting the
--            information required to create these INSERT statements. The tool,
--            while not currently part of the XDMoD repo will be shortly.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class)
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'allocation' AS name, 
		'Allocation' AS display, 
		'modw' AS schema_name, 
		'allocation' AS table_name, 
		'al' AS alias, 
		'account_id' AS id_column, 
		'long_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'account_id' AS fk_column, 
		'A funded project that is allowed to run jobs on resources.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByAllocation' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'grant_type' AS name, 
		'Grant Type' AS display, 
		'modw' AS schema_name, 
		'account' AS table_name, 
		'acc' AS alias, 
		'id' AS id_column, 
		'name' AS name_column, 
		'name' AS shortname_column, 
		'name' AS order_id_column, 
		'id' AS fk_column, 
		'A categorization of the projects/allocations.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByGrantType' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'institution' AS name, 
		'User Institution' AS display, 
		'modw' AS schema_name, 
		'organization' AS table_name, 
		'o' AS alias, 
		'id' AS id_column, 
		'long_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'id' AS fk_column, 
		'Organizations that have users with allocations.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByInstitution' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'jobsize' AS name, 
		'Job Size' AS display, 
		'modw' AS schema_name, 
		'processor_buckets' AS table_name, 
		'pb' AS alias, 
		'id' AS id_column, 
		'description' AS name_column, 
		'description' AS shortname_column, 
		'id' AS order_id_column, 
		'id' AS fk_column, 
		'A categorization of jobs into discrete groups based on the number of cores used by each job.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByJobSize' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'jobwalltime' AS name, 
		'Job Wall Time' AS display, 
		'modw' AS schema_name, 
		'job_times' AS table_name, 
		'jt' AS alias, 
		'id' AS id_column, 
		'description' AS name_column, 
		'description' AS shortname_column, 
		'id' AS order_id_column, 
		'id' AS fk_column, 
		'A categorization of jobs into discrete groups based on the total linear time each job took to execute.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByJobTime' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'nsfdirectorate' AS name, 
		'NSF Directorate' AS display, 
		'modw' AS schema_name, 
		'fieldofscience_hierarchy' AS table_name, 
		'fos' AS alias, 
		'directorate_id' AS id_column, 
		'directorate_description' AS name_column, 
		'directorate_abbrev' AS shortname_column, 
		'directorate_description' AS order_id_column, 
		'directorate_id' AS fk_column, 
		'The NSF directorate of the field of science indiciated on the allocation request pertaining to the running jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByNSFDirectorate' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'nsfstatus' AS name, 
		'User NSF Status' AS display, 
		'modw' AS schema_name, 
		'nsfstatuscode' AS table_name, 
		'ns' AS alias, 
		'id' AS id_column, 
		'name' AS name_column, 
		'name' AS shortname_column, 
		'name' AS order_id_column, 
		'id' AS fk_column, 
		'Categorization of the users who ran jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByNSFStatus' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'nodecount' AS name, 
		'Node Count' AS display, 
		'modw' AS schema_name, 
		'nodecount' AS table_name, 
		'n' AS alias, 
		'id' AS id_column, 
		'nodes' AS name_column, 
		'nodes' AS shortname_column, 
		'id' AS order_id_column, 
		'id' AS fk_column, 
		'A categorization of jobs into discrete groups based on node count.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByNodeCount' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'pi' AS name, 
		'PI' AS display, 
		'modw' AS schema_name, 
		'piperson' AS table_name, 
		'pip' AS alias, 
		'person_id' AS id_column, 
		'long_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'person_id' AS fk_column, 
		'The principal investigator of a project has a valid allocation, which can be used by him/her or the members of the project to run jobs on.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByPI' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'pi_institution' AS name, 
		'PI Institution' AS display, 
		'modw' AS schema_name, 
		'organization' AS table_name, 
		'o' AS alias, 
		'id' AS id_column, 
		'long_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'id' AS fk_column, 
		'Organizations that have PIs with allocations.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByPIInstitution' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'parentscience' AS name, 
		'Parent Science' AS display, 
		'modw' AS schema_name, 
		'fieldofscience_hierarchy' AS table_name, 
		'fos' AS alias, 
		'parent_id' AS id_column, 
		'parent_description' AS name_column, 
		'parent_description' AS shortname_column, 
		'parent_description' AS order_id_column, 
		'parent_id' AS fk_column, 
		'The parent of the field of science indiciated on the allocation request pertaining to the running jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByParentScience' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'person' AS name, 
		'User' AS display, 
		'modw' AS schema_name, 
		'person' AS table_name, 
		'p' AS alias, 
		'id' AS id_column, 
		'long_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'id' AS fk_column, 
		'A person who is on a PIs allocation, hence able run jobs on resources.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByPerson' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'provider' AS name, 
		'Service Provider' AS display, 
		'modw' AS schema_name, 
		'serviceprovider' AS table_name, 
		'sp' AS alias, 
		'organization_id' AS id_column, 
		'short_name' AS name_column, 
		'short_name' AS shortname_column, 
		'order_id' AS order_id_column, 
		'organization_id' AS fk_column, 
		'A service provider is an institution that hosts resources.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByProvider' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'queue' AS name, 
		'Queue' AS display, 
		'modw' AS schema_name, 
		'queue' AS table_name, 
		'q' AS alias, 
		'id' AS id_column, 
		'id' AS name_column, 
		'id' AS shortname_column, 
		'id' AS order_id_column, 
		'id' AS fk_column, 
		'Queue pertains to the low level job queues on each resource.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByQueue' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'resource' AS name, 
		'Resource' AS display, 
		'modw' AS schema_name, 
		'resourcefact' AS table_name, 
		'rf' AS alias, 
		'id' AS id_column, 
		'code' AS name_column, 
		'code' AS shortname_column, 
		'code' AS order_id_column, 
		'id' AS fk_column, 
		'A resource is a remote computer that can run jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByResource' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'resource_type' AS name, 
		'Resource Type' AS display, 
		'modw' AS schema_name, 
		'resourcetype' AS table_name, 
		'rt' AS alias, 
		'id' AS id_column, 
		'description' AS name_column, 
		'abbrev' AS shortname_column, 
		'description' AS order_id_column, 
		'id' AS fk_column, 
		'A categorization of resources into by their general capabilities.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByResourceType' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'fieldofscience' AS name, 
		'Field of Science' AS display, 
		'modw' AS schema_name, 
		'fieldofscience_hierarchy' AS table_name, 
		'fos' AS alias, 
		'id' AS id_column, 
		'description' AS name_column, 
		'description' AS shortname_column, 
		'order_id' AS order_id_column, 
		'id' AS fk_column, 
		'The field of science indicated on the allocation request pertaining to the running jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByScience' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.group_bys (module_id, realm_id, name, display, schema_name, table_name, alias, id_column, name_column, shortname_column, order_id_column, fk_column, description, class) 
SELECT inc.* 
FROM ( 
	SELECT 
		m.module_id as module_id, 
		r.realm_id, 
		'username' AS name, 
		'System Username' AS display, 
		'modw' AS schema_name, 
		'systemaccount' AS table_name, 
		'sa' AS alias, 
		'username' AS id_column, 
		'username' AS name_column, 
		'username' AS shortname_column, 
		'username' AS order_id_column, 
		'username' AS fk_column, 
		'The specific system username of the users who ran jobs.' as description, 
		'DataWarehouse/Query/Jobs/GroupBys/GroupByUsername' AS class 
FROM ${DESTINATION_SCHEMA}.modules m, ${DESTINATION_SCHEMA}.realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN ${DESTINATION_SCHEMA}.group_bys cur 
	ON cur.module_id = inc.module_id 
	AND cur.display = inc.display 
	AND cur.schema_name = inc.schema_name 
	AND cur.table_name = inc.table_name 
	AND cur.alias = inc.alias 
	AND cur.id_column = inc.id_column 
	AND cur.name_column = inc.name_column 
	AND cur.shortname_column = inc.shortname_column 
	AND cur.order_id_column = inc.order_id_column 
	AND cur.fk_column = inc.fk_column 
	AND cur.description = inc.description 
	AND cur.class = inc.class 
WHERE cur.group_by_id IS NULL;

