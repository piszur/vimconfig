\connect @@CON@@

-- schema.list_table_name -- listázás: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlViewSchemaListTableName

-- DROP VIEW IF EXISTS schema.list_table_name CASCADE;
CREATE OR REPLACE VIEW schema.list_table_name AS
  SELECT
    e.id,
    e.eid,
    e.is_active,
    e.creation_time,
    e.creation_user,
    bob.get_user_name(e.creation_user,e.creation_time) AS creation_user_name,
    e.modification_time,
    e.modification_user,
    bob.get_user_name(e.modification_user,e.modification_time) AS modification_user_name,

    -- TODO e.field_name
  FROM schema.table_name AS e
  WHERE e.is_active;

GRANT SELECT
  ON TABLE schema.list_table_name
  TO role_bob5admin, role_bob5user;

-- END schema.list_table_name.sql

