INSERT INTO
    modw.years
WITH RECURSIVE years(id, year, date, year_start, year_end, hours, seconds, year_start_ts, year_end_ts,
                     year_middle_ts) AS (
SELECT
    2000 * 100000                                                                      as id,
    2000                                                                               as year,
    TIMESTAMP('2000-01-01')                                                            as date,
    TIMESTAMP('2000-01-01 00:00:00')                                                   as year_start,
    TIMESTAMP('2000-12-31 23:59:59')                                                   as year_end,
    366 * 24                                                                           as hours,
    366 * 86400                                                                        as seconds,
    UNIX_TIMESTAMP(DATE('2000-01-01 00:00:00'))                                        as year_start_ts,
    UNIX_TIMESTAMP(DATE('2000-12-31 23:59:59'))                                        as year_end_ts,
    UNIX_TIMESTAMP(DATE_ADD(DATE('2000-01-01 00:00:00'), INTERVAL FLOOR(365 / 2) DAY)) as year_middle_ts
UNION ALL
SELECT
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 YEAR)) * 100000                as id,
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 YEAR))                         as year,
    DATE_ADD(date, INTERVAL 1 YEAR)                                            as date,
    DATE(CONCAT(DATE_ADD(date, INTERVAL 1 YEAR), ' 00:00:00'))                 as year_start,
    CONCAT(DATE(DATE_ADD(DATE_ADD(date, INTERVAL 1 YEAR), INTERVAL
                         timestampdiff(day,
                                       DATE(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                                   month(DATE_ADD(date, INTERVAL 1 YEAR)),
                                                   '-01')) /* beginning date */,
                                       date_add(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                                       month(DATE_ADD(date, INTERVAL 1 YEAR)),
                                                       '-01'),
                                                INTERVAL 1 YEAR) /* end date*/
                         ) - 1 DAY)),
           ' 23:59:59 ')                                                       as year_end,
    timestampdiff(day,
                  DATE(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                   month(DATE_ADD(date, INTERVAL 1 YEAR)),
                                   '-01')) /* beginning date */,
                  date_add(
                      concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                             month(DATE_ADD(date, INTERVAL 1 YEAR)), '-01'),
                      INTERVAL 1 YEAR) /* end date*/
    ) * 24 as hours,
    timestampdiff(day,
                  DATE(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                              month(DATE_ADD(date, INTERVAL 1 YEAR)),
                              '-01')) /* beginning date */,
                  date_add(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                  month(DATE_ADD(date, INTERVAL 1 YEAR)), '-01'),
                           INTERVAL 1 YEAR) /* end date*/
    ) * 86400 as seconds,
    UNIX_TIMESTAMP(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 YEAR), ' 00:00:00'))) as year_start_ts,
    UNIX_TIMESTAMP(DATE_ADD(
        DATE(CONCAT(DATE_ADD(date, INTERVAL 1 YEAR), ' 23:59:59')),
        INTERVAL timestampdiff(
            day,
            DATE(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                        month(DATE_ADD(date, INTERVAL 1 YEAR)),
                        '-01')
            ) /* beginning date */,
            date_add(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                            month(DATE_ADD(date, INTERVAL 1 YEAR)),
                            '-01'), INTERVAL 1 YEAR
            ) /* end date*/
        ) DAY)
    ) as year_end_ts,
    UNIX_TIMESTAMP(CONCAT(
        DATE(
            DATE_ADD(
                DATE_ADD(date, INTERVAL 1 YEAR),
                INTERVAL timestampdiff(
                             day,
                             DATE(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                         month(DATE_ADD(date, INTERVAL 1 YEAR)),
                                         '-01')) /* beginning date */,
                             date_add(concat(year(DATE_ADD(date, INTERVAL 1 YEAR)), '-',
                                             month(DATE_ADD(date, INTERVAL 1 YEAR)),
                                             '-01'),
                                      INTERVAL 1 YEAR) /* end date*/
                         ) - 1 DAY)
        ),
        ' 23:59:59 '))                                                         as year_middle_ts

FROM years
WHERE date < DATE('2037-01-01'))
SELECT id, year, year_start, year_end, hours, seconds, year_start_ts, year_end_ts, year_middle_ts
FROM years as new
