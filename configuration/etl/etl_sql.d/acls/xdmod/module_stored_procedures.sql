-- =============================================================================
-- NAME:      module_stored_procedures.sql
-- EXECUTION: once on installation
-- PURPOSE:   Provides some helper procedures to ease dealing with modules and
--            their associated versions.
-- =============================================================================

DROP PROCEDURE IF EXISTS ${DESTINATION_SCHEMA}.add_module_with_version;

CREATE PROCEDURE ${DESTINATION_SCHEMA}.add_module_with_version
  (IN _name          VARCHAR(255),
   IN _display       VARCHAR(1024),
   IN _version_major INTEGER,
   IN _version_minor INTEGER,
   IN _version_micro INTEGER,
   IN _version_patch VARCHAR(12)
  )
  BEGIN
    DECLARE moduleVersionId INT;
    DECLARE moduleId INT;

    INSERT INTO ${DESTINATION_SCHEMA}.module_versions (module_id, version_major, version_minor, version_micro, version_patch, created_on, last_modified_on)
    VALUES
      (0, _version_major, _version_minor, _version_micro, _version_patch, NOW(),
       NOW());
    SET moduleVersionId = LAST_INSERT_ID();

    INSERT INTO ${DESTINATION_SCHEMA}.modules (name, current_version_id, display, enabled)
    VALUES (_name, moduleVersionId, _display, TRUE);

    SET moduleId = LAST_INSERT_ID();
    UPDATE ${DESTINATION_SCHEMA}.module_versions
    SET module_id = moduleId
    WHERE module_version_id = moduleVersionId;
  END;

--
DROP PROCEDURE IF EXISTS ${DESTINATION_SCHEMA}.add_module_with_default_version;

CREATE PROCEDURE ${DESTINATION_SCHEMA}.add_module_with_default_version
  (
    IN _name    VARCHAR(255),
    IN _display VARCHAR(1024)
  )
  BEGIN
    CALL ${DESTINATION_SCHEMA}.add_module_with_version(_name, _display, 0, 0, 1, '');
  END
--
DROP PROCEDURE IF EXISTS ${DESTINATION_SCHEMA}.add_module_version;

CREATE PROCEDURE ${DESTINATION_SCHEMA}.add_module_version
  (
    IN _name VARCHAR(255),
    IN _version_major INT,
    IN _version_minor INT,
    IN _version_micro INT,
    IN _version_patch VARCHAR(12)
  )
  BEGIN
    DECLARE moduleId, moduleVersionId INT;

    SELECT module_id INTO moduleId FROM ${DESTINATION_SCHEMA}.modules WHERE name = _name;

    INSERT INTO ${DESTINATION_SCHEMA}.module_versions(module_id, version_major, version_minor, version_micro, version_patch)
    VALUES(moduleId, _version_major, _version_minor, _version_micro, _version_patch);
    SET moduleVersionId = LAST_INSERT_ID();

    UPDATE ${DESTINATION_SCHEMA}.modules SET current_version_id = moduleVersionId WHERE module_id = moduleId;

  END

