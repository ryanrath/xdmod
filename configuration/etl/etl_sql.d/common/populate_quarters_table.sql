INSERT INTO
    modw.quarters
WITH RECURSIVE quarters(id,
                        year,
                        date,
                        quarter,
                        quarter_start,
                        quarter_end,
                        hours,
                        seconds,
                        quarter_start_ts,
                        quarter_end_ts,
                        quarter_middle_ts
    ) AS (SELECT
              2000 * 100000 + 1                                as id, 2000 as year, DATE('2000-01-01') as date,
              1                                                as quarter,
              timestamp('2000-01-01 00:00:00')                 as quarter_start,
              timestamp('2000-03-31 23:59:59')                 as quarter_end,
              timestampdiff(day, concat(year(DATE('2000-01-01')), '-', month(DATE('2000-01-01')), '-01'),
                            date_add(concat(year(DATE('2000-01-01')), '-', month(DATE('2000-01-01')), '-01'), interval 1
                                     quarter)) * 24            as hours,
              timestampdiff(day, concat(year(DATE('2000-01-01')), '-', month(DATE('2000-01-01')), '-01'),
                            date_add(concat(year(DATE('2000-01-01')), '-', month(DATE('2000-01-01')), '-01'), interval 1
                                     quarter)) * 86400         as seconds,
              UNIX_TIMESTAMP(DATE('2000-01-01 00:00:00'))      as quarter_start_ts,
              UNIX_TIMESTAMP(TIMESTAMP('2000-03-31 23:59:59')) as quater_end_ts,
              UNIX_TIMESTAMP(TIMESTAMP('2000-01-15 12:00:00')) as quarter_middle_ts
          UNION ALL
          SELECT
                      EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 QUARTER)) * 100000 +
                      EXTRACT(QUARTER FROM DATE_ADD(date, INTERVAL 1 QUARTER))                                     as id,
                      EXTRACT(YEAR FROM DATE_ADD(date, INTERVAL 1 QUARTER))                                        as year,
                      DATE_ADD(date, INTERVAL 1 QUARTER)                                                           as date,
                      EXTRACT(QUARTER FROM DATE_ADD(date, INTERVAL 1 QUARTER))                                     as quarter,
                      DATE(CONCAT(DATE_ADD(date, INTERVAL 1 QUARTER), ' 00:00:00'))                                as quarter_start,
                      CONCAT(DATE(DATE_ADD(DATE_ADD(date, INTERVAL 1 QUARTER), INTERVAL timestampdiff(day, DATE(concat(
                          year(DATE_ADD(date, INTERVAL 1 quarter)), '-', month(DATE_ADD(date, INTERVAL 1 quarter)),
                          '-01')) /* beginning date */, date_add(concat(year(DATE_ADD(date, INTERVAL 1 quarter)), '-',
                                                                        month(DATE_ADD(date, INTERVAL 1 quarter)),
                                                                        '-01'), INTERVAL 1 quarter) /* end date*/
                                                                                        ) - 1 DAY)),
                             ' 23:59:59 ')                                                                         as quarter_end,
                      timestampdiff(day, concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)), '-',
                                                month(DATE_ADD(date, INTERVAL 1 QUARTER)), '-01'), date_add(
                                        concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)), '-',
                                               month(DATE_ADD(date, INTERVAL 1 QUARTER)), '-01'), interval 1 QUARTER)) *
                      24                                                                                           as hours,
                      timestampdiff(day, concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)), '-',
                                                month(DATE_ADD(date, INTERVAL 1 QUARTER)), '-01'), date_add(
                                        concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)), '-',
                                               month(DATE_ADD(date, INTERVAL 1 QUARTER)), '-01'), interval 1 QUARTER)) *
                      86400                                                                                        as seconds,
                      UNIX_TIMESTAMP(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 QUARTER), ' 00:00:00')))                as quarter_start_ts,
                      UNIX_TIMESTAMP(CONCAT(DATE(DATE_ADD(DATE_ADD(date, INTERVAL 1 QUARTER), INTERVAL
                                                          timestampdiff(day, DATE(concat(
                                                              year(DATE_ADD(date, INTERVAL 1 quarter)), '-',
                                                              month(DATE_ADD(date, INTERVAL 1 quarter)),
                                                              '-01')) /* beginning date */, date_add(concat(
                                                                                                         year(DATE_ADD(date, INTERVAL 1 quarter)),
                                                                                                         '-',
                                                                                                         month(DATE_ADD(date, INTERVAL 1 quarter)),
                                                                                                         '-01'),
                                                                                                     INTERVAL 1
                                                                                                     quarter) /* end date*/
                                                          ) - 1 DAY)),
                                            ' 23:59:59 '))                                                         as quarter_end_ts,
                      UNIX_TIMESTAMP(TIMESTAMP(CONCAT(
                          DATE_ADD(DATE(CONCAT(DATE_ADD(date, INTERVAL 1 QUARTER), ' 00:00:00'))/* START DATE */,
                                   INTERVAL FLOOR(timestampdiff(day,
                                                                DATE(concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)),
                                                                            '-',
                                                                            month(DATE_ADD(date, INTERVAL 1 QUARTER)),
                                                                            '-01')), date_add(
                                                                    concat(year(DATE_ADD(date, INTERVAL 1 QUARTER)),
                                                                           '-',
                                                                           month(DATE_ADD(date, INTERVAL 1 QUARTER)),
                                                                           '-01'), interval 1 QUARTER)) / 2) DAY),
                          ' 12:00')))/* FLOOR(Number of days in the quarter / 2) */                                as quarter_middle_ts
          FROM quarters
          WHERE date < DATE('2037-09-30'))
SELECT
    id, year, quarter, quarter_start, quarter_end, hours, seconds, quarter_start_ts, quarter_end_ts, quarter_middle_ts
FROM quarters
