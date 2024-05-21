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
