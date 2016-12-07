-- =============================================================================
-- NAME:      modules.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides some initial data for the module / module_versions table.
--            This file was generated manually based on knowledge of the
--            currently supported modules.
-- =============================================================================

CALL ${DESTINATION_SCHEMA}.add_module_with_version('xdmod', 'XDMoD', 6, 5, 0, '');
