-- =============================================================================
-- NAME:      statistics.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides initial population of the 'statistics' table. This file was
--            generated automatically by a tool project called 'parser'.
--            created programmatically by utilizing a tool called 'parser' that
--            was written expressly for the purpose of processing existing PHP
--            files ( within a provided directory ) and extracting the
--            information required to create these INSERT statements. The tool,
--            while not currently part of the XDMoD repo will be shortly.
-- =============================================================================

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description)
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'active_allocation_count' AS NAME, 
		'Number of Allocations: Active' AS display, 
		'active_allocation_count' AS alias, 
		'Number of Allocations' AS unit, 
		'0'+0 AS decimals, 
		'count(distinct(jf.account_id))' AS formula, 
		'The total number of funded projects that used resources.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'active_institution_count' AS NAME, 
		'Number of Institutions: Active' AS display, 
		'active_institution_count' AS alias, 
		'Number of Institutions' AS unit, 
		'0'+0 AS decimals, 
		'count(distinct(jf.person_organization_id))' AS formula, 
		'The total number of institutions that used resources.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'active_pi_count' AS NAME, 
		'Number of PIs: Active' AS display, 
		'active_pi_count' AS alias, 
		'Number of PIs' AS unit, 
		'0'+0 AS decimals, 
		'count(distinct(jf.principalinvestigator_person_id))' AS formula, 
		'The total number of PIs that used resources.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'active_resource_count' AS NAME, 
		'Number of Resources: Active' AS display, 
		'active_resource_count' AS alias, 
		'Number of Resources' AS unit, 
		'0'+0 AS decimals, 
		'count(distinct(jf.resource_id))' AS formula, 
		'The total number of active resources.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'active_person_count' AS NAME, 
		'Number of Users: Active' AS display, 
		'active_person_count' AS alias, 
		'Number of Users' AS unit, 
		'0'+0 AS decimals, 
		'count(distinct(jf.person_id))' AS formula, 
		'The total number of users that used resources.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_cpu_hours' AS NAME, 
		'CPU Hours: Per Job' AS display, 
		'avg_cpu_hours' AS alias, 
		'CPU Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sum(jf.cpu_time/3600.0)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),0)' AS formula, 
		'The average CPU hours (number of CPU cores x wall time hours) per job.<br/>For each job, the CPU usage is aggregated. For example, if a job used 1000 CPUs for one minute, it would be aggregated as 1000 CPU minutes or 16.67 CPU hours.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_node_hours' AS NAME, 
		'Node Hours: Per Job' AS display, 
		'avg_node_hours' AS alias, 
		'Node Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sum(jf.node_time/3600.0)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),0)' AS formula, 
		'The average node hours (number of nodes x wall time hours) per job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_processors' AS NAME, 
		'Job Size: Per Job' AS display, 
		'avg_processors' AS alias, 
		'Core Count' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(ceil(sum(jf.processors*jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')),0)' AS formula, 
		'The average job size per job.<br> <i>Job Size: </i>The number of processor cores used by a (parallel) job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_waitduration_hours' AS NAME, 
		'Wait Hours: Per Job' AS display, 
		'avg_waitduration_hours' AS alias, 
		'Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sum(jf.waitduration/3600.0)/sum(jf.started_job_count),0)' AS formula, 
		'The average time, in hours, a job waits before execution on the designated resource.<br/> <i>Wait Time: </i>Wait time is defined as the linear time between submission of a job by a user until it begins to execute.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_wallduration_hours' AS NAME, 
		'Wall Hours: Per Job' AS display, 
		'avg_wallduration_hours' AS alias, 
		'Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sum(jf.wallduration/3600.0)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),0)' AS formula, 
		'The average time, in hours, a job takes to execute.<br/> <i>Wall Time:</i> Wall time is defined as the linear time between start and end time of execution for a particular job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'expansion_factor' AS NAME, 
		'User Expansion Factor' AS display, 
		'expansion_factor' AS alias, 
		'User Expansion Factor' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(sum(jf.sum_weighted_expansion_factor)/sum(jf.sum_job_weights),0)' AS formula, 
		'Gauging job-turnaround time, it measures the ratio of wait time and the total time from submission to end of execution.<br/> <i>User Expansion Factor = ((wait duration + wall duration) / wall duration). </i>' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'job_count' AS NAME, 
		'Number of Jobs Ended' AS display, 
		'job_count' AS alias, 
		'Number of Jobs' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(sum(jf.job_count),0)' AS formula, 
		'The total number of jobs that ended within the selected duration.<br/> <i>Job: </i>A scheduled process for a computer resource in a batch processing environment.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'avg_job_size_weighted_by_cpu_hours' AS NAME, 
		'Job Size: Weighted By CPU Hours' AS display, 
		'avg_job_size_weighted_by_cpu_hours' AS alias, 
		'Core Count' AS unit, 
		'1'+0 AS decimals, 
		'
                COALESCE(
                    SUM(jf.processors * jf.cpu_time) / SUM(jf.cpu_time),
                    0
                )
            ' AS formula, 
		'The average job size weighted by CPU Hours. Defined as <br><i>Average Job Size Weighted By CPU Hours: </i> sum(i = 0 to n){job i core count*job i cpu hours}/sum(i = 0 to n){job i cpu hours}' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'max_processors' AS NAME, 
		'Job Size: Max' AS display, 
		'max_processors' AS alias, 
		'Core Count' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(ceil(max(jf.processors)),0)' AS formula, 
		'The maximum size job in number of cores.<br/> <i>Job Size: </i>The total number of processor cores used by a (parallel) job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'min_processors' AS NAME, 
		'Job Size: Min' AS display, 
		'min_processors' AS alias, 
		'Core Count' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(ceil(min(case when jf.processors = 0 then null else jf.processors end)),0)' AS formula, 
		'The minimum size job in number of cores.<br/> <i>Job Size: </i>The total number of processor cores used by a (parallel) job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'node_utilization' AS NAME, 
		'Node Utilization' AS display, 
		'node_utilization' AS alias, 
		'%' AS unit, 
		'2'+0 AS decimals, 
		'\n 100.0 * (\n COALESCE(\n SUM(jf.node_time / 3600.0)\n /\n (\n SELECT\n SUM(ra.percent * inner_days.hours * rs.q_nodes / 100.0)\n FROM\n modw.resourcespecs rs,\n modw.resource_allocated ra,\n modw.days inner_days\n WHERE\n inner_days.day_middle_ts BETWEEN ra.start_date_ts AND COALESCE(ra.end_date_ts, 2147483647)\n AND inner_days.day_middle_ts BETWEEN rs.start_date_ts AND COALESCE(rs.end_date_ts, 2147483647)\n AND inner_days.day_middle_ts BETWEEN $date_table_start_ts AND $date_table_end_ts\n AND ra.resource_id = rs.resource_id\n AND FIND_IN_SET(\n rs.resource_id,\n GROUP_CONCAT(DISTINCT jf.resource_id)\n ) <> 0\n ),\n 0\n )\n )\n ' AS formula, 
		'The percentage of resource nodes utilized by jobs.<br/><i> Node Utilization:</i> the ratio of the total node hours consumed by jobs over a given time period divided by the total node hours that the system could have potentially provided during that period. It does not include non- jobs.<br/>This value is only accurate if node sharing is not allowed' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'normalized_avg_processors' AS NAME, 
		'Job Size: Normalized' AS display, 
		'normalized_avg_processors' AS alias, 
		'% of Total Cores' AS unit, 
		'1'+0 AS decimals, 
		'100.0*coalesce(ceil(sum(jf.processors*jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'))/(select sum(rrf.processors) from modw.resourcespecs rrf where find_in_set(rrf.resource_id,group_concat(distinct jf.resource_id)) <> 0 and \' . $query_instance->getAggregationUnit()->getUnitName() . \'_end_ts >= rrf.start_date_ts and (rrf.end_date_ts is null or \' . $query_instance->getAggregationUnit()->getUnitName() . \'_end_ts <= rrf.end_date_ts)),0)' AS formula, 
		'The percentage average size job over total machine cores.<br> <i>Normalized Job Size: </i>The percentage total number of processor cores used by a (parallel) job over the total number of cores on the machine.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'burn_rate' AS NAME, 
		'Allocation Burn Rate' AS display, 
		'burn_rate' AS alias, 
		'%' AS unit, 
		'2'+0 AS decimals, 
		'100.00*coalesce((sum(jf.local_charge)/" . ($query_instance != NULL ? $query_instance->getDurationFormula() : 1) . ")\n\t\t\t\t\t\t\t/\n\t\t\t\t\t\t\t(select sum(alc.base_allocation*"coalesce((select conversion_factor \n\t\t\t\t from modw.allocationadjustment aladj\n\t\t\t\t where aladj.allocation_resource_id = 1546\n\t\t\t\t and aladj.site_resource_id = alc.resource_id\n\t\t\t\t and aladj.start_date <= alc.initial_start_date and (aladj.end_date is null or alc.initial_start_date <= aladj.end_date)\n\t\t\t\t limit 1\n\t\t\t\t ), 1.0)"/((unix_timestamp(alc.end_date) - unix_timestamp(alc.initial_start_date))/3600.0)) from modw.allocation alc where find_in_set(alc.id,group_concat(distinct jf.allocation_id)) <> 0 ),0)\n\t\t\t\t\t\t\t' AS formula, 
		'The percentage of allocation usage in the given duration.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'rate_of_usage' AS NAME, 
		'Allocation Usage Rate' AS display, 
		'rate_of_usage' AS alias, 
		'XD SU/Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sum(jf.local_charge)/" . ($query_instance != NULL ? $query_instance->getDurationFormula() : 1) . ",0)' AS formula, 
		'The rate of allocation usage in XD SUs per hour.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'running_job_count' AS NAME, 
		'Number of Jobs Running' AS display, 
		'running_job_count' AS alias, 
		'Number of Jobs' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(sum(jf.running_job_count),0)' AS formula, 
		'The total number of running jobs.<br/> <i>Job: </i>A scheduled process for a computer resource in a batch processing environment.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'sem_avg_cpu_hours' AS NAME, 
		'Std Dev: CPU Hours: Per Job' AS display, 
		'sem_avg_cpu_hours' AS alias, 
		'CPU Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sqrt((sum(jf.sum_cpu_time_squared)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'))-pow(sum(jf.cpu_time)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),2))/sqrt(sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')),0)/3600.0' AS formula, 
		'The standard error of the average CPU hours by each job.<br/> <i>Std Err of the Avg: </i> The standard deviation of the sample mean, estimated by the sample estimate of the population standard deviation (sample standard deviation) divided by the square root of the sample size (assuming statistical independence of the values in the sample).' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'sem_avg_node_hours' AS NAME, 
		'Std Dev: Node Hours: Per Job' AS display, 
		'sem_avg_node_hours' AS alias, 
		'Node Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sqrt((sum(jf.sum_node_time_squared)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'))-pow(sum(jf.node_time)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),2))/sqrt(sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')),0)/3600.0' AS formula, 
		'The standard error of the average node hours by each job.<br/> <i>Std Err of the Avg: </i> The standard deviation of the sample mean, estimated by the sample estimate of the population standard deviation (sample standard deviation) divided by the square root of the sample size (assuming statistical independence of the values in the sample).' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'sem_avg_processors' AS NAME, 
		'Std Dev: Job Size: Per Job' AS display, 
		'sem_avg_processors' AS alias, 
		'Core Count' AS unit, 
		'2'+0 AS decimals, 
		'coalesce( sqrt( (sum(pow(jf.processors,2)*jf.job_count)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')) - pow(sum(jf.processors*jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),2) ) /sqrt(sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')) ,0)' AS formula, 
		'The standard error of the average size job in number of cores. <br/> <i>Std Err of the Avg: </i> The standard deviation of the sample mean, estimated by the sample estimate of the population standard deviation (sample standard deviation) divided by the square root of the sample size (assuming statistical independence of the values in the sample).' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'sem_avg_waitduration_hours' AS NAME, 
		'Std Dev: Wait Hours: Per Job' AS display, 
		'sem_avg_waitduration_hours' AS alias, 
		'Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sqrt((sum(coalesce(jf.sum_waitduration_squared,0))/sum(jf.started_job_count))-pow(sum(coalesce(jf.waitduration,0))/sum(jf.started_job_count),2))/sqrt(sum(jf.started_job_count)),0)/3600.0' AS formula, 
		'The standard error of the average time, in hours, an job had to wait until it began to execute.<br/> <i>Std Err of the Avg: </i> The standard deviation of the sample mean, estimated by the sample estimate of the population standard deviation (sample standard deviation) divided by the square root of the sample size (assuming statistical independence of the values in the sample).' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'sem_avg_wallduration_hours' AS NAME, 
		'Std Dev: Wall Hours: Per Job' AS display, 
		'sem_avg_wallduration_hours' AS alias, 
		'Hour' AS unit, 
		'2'+0 AS decimals, 
		'coalesce(sqrt((sum(jf.sum_wallduration_squared)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'))-pow(sum(jf.wallduration)/sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \'),2))/sqrt(sum(jf.\' . $query_instance->getQueryType() == \'aggregate\' ? \'job_count\' : \'running_job_count\' . \')),0)/3600.0' AS formula, 
		'The standard error of the average time each job took to execute.<br/> <i>Std Err of the Avg: </i> The standard deviation of the sample mean, estimated by the sample estimate of the population standard deviation (sample standard deviation) divided by the square root of the sample size (assuming statistical independence of the values in the sample).' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'started_job_count' AS NAME, 
		'Number of Jobs Started' AS display, 
		'started_job_count' AS alias, 
		'Number of Jobs' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(sum(jf.started_job_count),0)' AS formula, 
		'The total number of jobs that started executing within the selected duration.<br/> <i>Job: </i>A scheduled process for a computer resource in a batch processing environment.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'submitted_job_count' AS NAME, 
		'Number of Jobs Submitted' AS display, 
		'submitted_job_count' AS alias, 
		'Number of Jobs' AS unit, 
		'0'+0 AS decimals, 
		'coalesce(sum(jf.submitted_job_count),0)' AS formula, 
		'' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'total_cpu_hours' AS NAME, 
		'CPU Hours: Total' AS display, 
		'total_cpu_hours' AS alias, 
		'CPU Hour' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(sum(jf.cpu_time/3600.0),0)' AS formula, 
		'The total CPU hours (number of CPU cores x wall time hours) used by jobs.<br/>For each job, the CPU usage is aggregated. For example, if a job used 1000 CPUs for one minute, it would be aggregated as 1000 CPU minutes or 16.67 CPU hours.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'total_node_hours' AS NAME, 
		'Node Hours: Total' AS display, 
		'total_node_hours' AS alias, 
		'Node Hour' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(sum(jf.node_time/3600.0),0)' AS formula, 
		'The total node hours (number of nodes x wall time hours) used by jobs.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'total_waitduration_hours' AS NAME, 
		'Wait Hours: Total' AS display, 
		'total_waitduration_hours' AS alias, 
		'Hour' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(sum(jf.waitduration/3600.0),0)' AS formula, 
		'The total time, in hours, jobs waited before execution on their designated resource.<br/> <i>Wait Time: </i>Wait time is defined as the linear time between submission of a job by a user until it begins to execute.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'total_wallduration_hours' AS NAME, 
		'Wall Hours: Total' AS display, 
		'total_wallduration_hours' AS alias, 
		'Hour' AS unit, 
		'1'+0 AS decimals, 
		'coalesce(sum(jf.wallduration/3600.0),0)' AS formula, 
		'The total time, in hours, jobs took to execute.<br/> <i>Wall Time:</i> Wall time is defined as the linear time between start and end time of execution for a particular job.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;

INSERT INTO statistics (module_id, realm_id, name, display, alias, unit, decimals, formula, description) 
SELECT inc.* FROM ( 
	SELECT 
		m.module_id AS module_id, 
		r.realm_id AS realm_id, 
		'utilization' AS NAME, 
		'Utilization' AS display, 
		'utilization' AS alias, 
		'%' AS unit, 
		'2'+0 AS decimals, 
		'\n 100.0 * (\n COALESCE(\n SUM(jf.cpu_time / 3600.0)\n /\n (\n SELECT SUM( ra.percent * inner_days.hours * rs.processors / 100.0 )\n FROM modw.resourcespecs rs,\n modw.resource_allocated ra,\n modw.days inner_days\n WHERE\n inner_days.day_middle_ts BETWEEN ra.start_date_ts AND coalesce(ra.end_date_ts, 2147483647) AND\n inner_days.day_middle_ts BETWEEN rs.start_date_ts AND coalesce(rs.end_date_ts, 2147483647) AND\n inner_days.day_middle_ts BETWEEN $date_table_start_ts AND $date_table_end_ts AND\n ra.resource_id = rs.resource_id\n AND FIND_IN_SET(\n rs.resource_id,\n GROUP_CONCAT(DISTINCT jf.resource_id)\n ) <> 0\n ),\n 0\n )\n )\n ' AS formula, 
		'The percentage of the obligation of a resource that has been utilized by jobs.<br/><i> Utilization:</i> The ratio of the total CPU hours consumed by jobs over a given time period divided by the total CPU hours that the system is contractually required to provide to during that period. It does not include non- jobs.<br/>It is worth noting that this value is a rough estimate in certain cases where the resource providers don\'t provide accurate records of their system specifications, over time.' AS description 
FROM modules m, realms r 
WHERE m.name = 'xdmod' 
	AND r.name = LOWER('Jobs')) inc 
LEFT JOIN statistics cur 
	ON cur.module_id = inc.module_id 
	AND cur.name = inc.name 
	AND cur.display = inc.display 
	AND cur.alias = inc.alias 
	AND cur.unit = inc.unit 
	AND cur.decimals = inc.decimals 
	AND replace(replace(cur.formula, ' ', ''), '\n', '') LIKE replace(replace(inc.formula, ' ', ''), '\n', '') 
	AND replace(replace(cur.description, ' ', ''), '\n', '') LIKE replace(replace(inc.description, ' ', ''), '\n', '') 
WHERE cur.statistic_id IS NULL;




