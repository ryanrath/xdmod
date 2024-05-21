INSERT INTO
    modw.months
WITH RECURSIVE months(id, year, date, month, month_start, month_end, hours, seconds, month_start_ts,
                      month_end_ts,
                      month_middle_ts) AS (
SELECT
    2001 * 100000 + 1                                as id,
    2001                                             as year,
    DATE('2001-01-01')                               as date,
    1                                                as month,
    TIMESTAMP('2001-01-01 00:00:00')                 as month_start,
    TIMESTAMP('2001-01-31 23:59:59')                 as month_end,
    31 * 24                                          as hours,
    31 * 86400                                       as seconds,
    UNIX_TIMESTAMP(TIMESTAMP('2001-01-01 00:00:00')) as month_start_ts,
    UNIX_TIMESTAMP(TIMESTAMP('2001-01-31 23:59:59')) as month_end_ts,
    UNIX_TIMESTAMP(TIMESTAMP('2001-01-15 12:00:00')) as month_middle_ts
UNION ALL
SELECT
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 MONTH)) * 100000 + EXTRACT(MONTH FROM DATE_ADD(date, INTERVAL 1 MONTH)) as id,
    EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 MONTH))                                                                 as year,
    DATE_ADD(date, INTERVAL 1 MONTH)                                                                                    as date,
    EXTRACT(MONTH FROM DATE_ADD(date, INTERVAL 1 MONTH))                                                                as month,
    DATE(CONCAT(DATE_ADD(date, INTERVAL 1 MONTH), ' 00:00:00'))                                                         as month_start,
    CONCAT(
        EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 MONTH)), /* YEAR */
        '-', EXTRACT(MONTH FROM DATE_ADD(date, INTERVAL 1 MONTH)),/* MONTH */
        '-', timestampdiff(day, concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
            '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
            '-01'), date_add(concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                '-01'), interval 1 month)),
        ' 23:59:59')                                                                                                    as month_end,
        timestampdiff(day,
                      concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                             '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                             '-01'),
                      date_add(concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                      '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                      '-01'),
                               interval 1 month)) * 24                                                                  as hours,
        timestampdiff(day,
                      concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                             '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                             '-01'),
                      date_add(concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                      '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                      '-01'),
                               interval 1 month)) * 86400                                                               as seconds,
        UNIX_TIMESTAMP(TIMESTAMP(CONCAT(DATE_ADD(date, INTERVAL 1 MONTH), ' 00:00:00')))                                as month_start_ts,
        UNIX_TIMESTAMP(CONCAT(EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 MONTH)), /* YEAR */
                              '-', EXTRACT(MONTH FROM DATE_ADD(date, INTERVAL 1 MONTH)),/* MONTH */
                              '-', timestampdiff(
                                       day,
                                       concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                              '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                              '-01'),
                                       date_add(concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                       '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                       '-01'),
                                                interval 1 month)),
                             ' 23:59:59'))                                                                              as month_end_ts,
        UNIX_TIMESTAMP(CONCAT(EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 MONTH)), /* YEAR */
                              '-', EXTRACT(MONTH FROM DATE_ADD(date, INTERVAL 1 MONTH)),/* MONTH */
                              '-', FLOOR(timestampdiff(day, concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                                   '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                                   '-01'),
                                                       date_add(concat(year(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                                       '-', month(DATE_ADD(date, INTERVAL 1 MONTH)),
                                                                       '-01'),
                                                                interval 1 month)) / 2),
                             ' 12:00:00'))                                                                              as month_middle_ts
FROM months
WHERE date < DATE('2037-11-30'))
SELECT id, year, month, month_start, month_end, hours, seconds, month_start_ts, month_end_ts, month_middle_ts
FROM months;
