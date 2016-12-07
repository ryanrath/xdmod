-- =============================================================================
-- NAME:      tabs.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides initial population of the 'tabs' table. It was generated
--            manually by processing the
--            'roles.json->roles->[role]->permitted_modules' sections.
-- =============================================================================

INSERT INTO ${DESTINATION_SCHEMA}.tabs (module_id, name, display, position, is_default, javascript_class, javascript_reference, tooltip, user_manual_section_name)
  SELECT inc.*
  FROM (SELECT
          m.module_id,
          'tg_summary'                   AS name,
          'Summary'                      AS display,
          100                            AS position,
          TRUE                           AS is_default,
          'XDMoD.Module.Summary'         AS javascript_class,
          'CCR.xdmod.ui.tgSummaryViewer' AS javascript_reference,
          'Displays summary information' AS tooltip,
          'Summary Tab'                  AS user_manual_section_name
        FROM ${DESTINATION_SCHEMA}.modules m
        WHERE m.name = 'xdmod'
       ) inc
    LEFT JOIN ${DESTINATION_SCHEMA}.tabs cur
      ON cur.module_id = inc.module_id
         AND cur.name = inc.name
         AND cur.display = inc.display
         AND cur.position = inc.position
         AND cur.is_default = inc.is_default
         AND cur.javascript_class = inc.javascript_class
         AND cur.javascript_reference = inc.javascript_reference
         AND cur.tooltip = inc.tooltip
         AND cur.user_manual_section_name = inc.user_manual_section_name
  WHERE cur.tab_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.tabs (module_id, name, display, position, is_default, javascript_class, javascript_reference, tooltip, user_manual_section_name)
  SELECT inc.*
  FROM (SELECT
          m.module_id,
          'tg_usage'                        AS name,
          'Usage'                           AS display,
          200                               AS position,
          FALSE                             AS is_default,
          'XDMoD.Module.Usage'              AS javascript_class,
          'CCR.xdmod.ui.chartViewerTGUsage' AS javascript_reference,
          'Displays usage'                  AS tooltip,
          'Usage Tab'                       AS user_manual_section_name
        FROM ${DESTINATION_SCHEMA}.modules m
        WHERE m.name = 'xdmod'
       ) inc
    LEFT JOIN ${DESTINATION_SCHEMA}.tabs cur
      ON cur.module_id = inc.module_id
         AND cur.name = inc.name
         AND cur.display = inc.display
         AND cur.position = inc.position
         AND cur.is_default = inc.is_default
         AND cur.javascript_class = inc.javascript_class
         AND cur.javascript_reference = inc.javascript_reference
         AND cur.tooltip = inc.tooltip
         AND cur.user_manual_section_name = inc.user_manual_section_name
  WHERE cur.tab_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.tabs (module_id, name, display, position, is_default, javascript_class, javascript_reference, tooltip, user_manual_section_name)
  SELECT inc.*
  FROM (SELECT
          m.module_id,
          'metric_explorer'             AS name,
          'Metric Explorer'             AS display,
          300                           AS position,
          FALSE                         AS is_default,
          'XDMoD.Module.MetricExplorer' AS javascript_class,
          'CCR.xdmod.ui.metricExplorer' AS javascript_reference,
          ''                            AS tooltip,
          'Metric Explorer'             AS user_manual_section_name
        FROM ${DESTINATION_SCHEMA}.modules m
        WHERE m.name = 'xdmod'
       ) inc
    LEFT JOIN ${DESTINATION_SCHEMA}.tabs cur
      ON cur.module_id = inc.module_id
         AND cur.name = inc.name
         AND cur.display = inc.display
         AND cur.position = inc.position
         AND cur.is_default = inc.is_default
         AND cur.javascript_class = inc.javascript_class
         AND cur.javascript_reference = inc.javascript_reference
         AND cur.tooltip = inc.tooltip
         AND cur.user_manual_section_name = inc.user_manual_section_name
  WHERE cur.tab_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.tabs (module_id, name, display, position, is_default, javascript_class, javascript_reference, tooltip, user_manual_section_name)
  SELECT inc.*
  FROM (SELECT
          m.module_id,
          'report_generator'             AS name,
          'Report Generator'             AS display,
          1000                           AS position,
          FALSE                          AS is_default,
          'XDMoD.Module.ReportGenerator' AS javascript_class,
          'CCR.xdmod.ui.reportGenerator' AS javascript_reference,
          ''                             AS tooltip,
          'Report Generator'             AS user_manual_section_name
        FROM ${DESTINATION_SCHEMA}.modules m
        WHERE m.name = 'xdmod'
       ) inc
    LEFT JOIN ${DESTINATION_SCHEMA}.tabs cur
      ON cur.module_id = inc.module_id
         AND cur.name = inc.name
         AND cur.display = inc.display
         AND cur.position = inc.position
         AND cur.is_default = inc.is_default
         AND cur.javascript_class = inc.javascript_class
         AND cur.javascript_reference = inc.javascript_reference
         AND cur.tooltip = inc.tooltip
         AND cur.user_manual_section_name = inc.user_manual_section_name
  WHERE cur.tab_id IS NULL;

INSERT INTO ${DESTINATION_SCHEMA}.tabs (module_id, name, display, position, is_default, javascript_class, javascript_reference, tooltip, user_manual_section_name)
  SELECT inc.*
  FROM (SELECT
          m.module_id,
          'about_xdmod'          AS name,
          'About'                AS display,
          10000                  AS position,
          FALSE                  AS is_default,
          'XDMoD.Module.About'   AS javascript_class,
          'CCR.xdmod.ui.aboutXD' AS javascript_reference,
          ''                     AS tooltip,
          'About'                AS user_manual_section_name
        FROM ${DESTINATION_SCHEMA}.modules m
        WHERE m.name = 'xdmod'
       ) inc
    LEFT JOIN ${DESTINATION_SCHEMA}.tabs cur
      ON cur.module_id = inc.module_id
         AND cur.name = inc.name
         AND cur.display = inc.display
         AND cur.position = inc.position
         AND cur.is_default = inc.is_default
         AND cur.javascript_class = inc.javascript_class
         AND cur.javascript_reference = inc.javascript_reference
         AND cur.tooltip = inc.tooltip
         AND cur.user_manual_section_name = inc.user_manual_section_name
  WHERE cur.tab_id IS NULL;
