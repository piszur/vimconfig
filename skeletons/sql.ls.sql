\connect @@CON@@

-- schema.ls_table_name -- listázás alapadatokkal: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/schemaDocHu/SchemaSqlViewSchemaLsTableName

-- DROP VIEW IF EXISTS schema.ls_table_name CASCADE;
CREATE OR REPLACE VIEW schema.ls_table_name AS
  SELECT
    e.id,
    e.eid,
    e.is_active,
    e.creation_time,
    e.creation_user,
    e.modification_time,
    e.modification_user,

    -- TODO e.field_name
  FROM schema.table_name AS e;

GRANT SELECT
  ON TABLE schema.ls_table_name
  TO role_bob5admin;

-- END schema.ls_table_name.sql
