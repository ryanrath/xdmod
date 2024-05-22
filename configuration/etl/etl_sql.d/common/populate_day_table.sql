/*
This is probably the easiest of the four queries to explain and all of them work on the same basic principle.
This method of generation uses a Recursive CTE ( https://mariadb.com/kb/en/recursive-common-table-expressions-overview/ )
in this case `days` to dynamically generate records for the `modw.days` table until the `WHERE` clause is no longer
true, in this case when `date` >= "2038-01-18".

It does this by using a standard recursive cte pattern whereby two SELECT statements are `UNION ALL`'d. The base query
executes first, taking whatever it needs to compute the result R0. The second recursive query is executed taking R0 as
input — that is R references R0 in the recursive query when first executed. The recursive query produces the result R1,
and that is what R will reference at the next invocation, and so on until a recursive query returns an empty result. At
that point, all intermediate results are combined together.
*/

INSERT INTO
    modw.days
WITH RECURSIVE days(date, year, id, day, day_start, day_end, hours, seconds, day_start_ts, day_end_ts, day_middle_ts)
                   as (
SELECT
    DATE ('2001-01-01')                          as date,
    2001                                         as year,
    2001 * 1000000 + 1                           as id,
    1                                            as day,
    DATE ('2001-01-01 00:00:00')                 as day_start,
    DATE ('2001-01-01 23:59:59')                 as day_end,
    24                                           as hours,
    86400                                        as seconds,
    UNIX_TIMESTAMP(DATE ('2001-01-01 00:00:00')) as day_start_ts,
    UNIX_TIMESTAMP(DATE ('2001-01-01 23:59:59')) as day_end_ts,
    UNIX_TIMESTAMP(DATE ('2001-01-01 12:00:00')) as day_middle_ts
UNION ALL
SELECT
    DATE_ADD(date, INTERVAL 1 DAY)                                                                          as date,
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 DAY))                                                       as year,
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 DAY)) * 1000000 + DAYOFYEAR(DATE_ADD(date, INTERVAL 1 DAY)) as id,
    DAYOFYEAR(DATE_ADD(date, INTERVAL 1 DAY))                                                               as day,
    DATE(CONCAT(DATE_ADD(date, INTERVAL 1 DAY), ' 00:00:00'))                                               as day_start,
    DATE(CONCAT(DATE_ADD(date, INTERVAL 1 DAY), ' 23:59:59'))                                               as day_end,
    24                                                                                                      as hours,
    86400                                                                                                   as seconds,
    UNIX_TIMESTAMP(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 DAY), ' 00:00:00')))                               as day_start_ts,
    UNIX_TIMESTAMP(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 DAY), ' 23:59:59')))                               as day_end_ts,
    UNIX_TIMESTAMP(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 DAY), ' 12:00:00')))                               as day_middle_ts
FROM days
WHERE date < DATE ('2038-01-18'))
SELECT id, year, day, day_start, day_end, hours, seconds, day_start_ts, day_end_ts, day_middle_ts
FROM days;
