\connect @@CON@@

-- schema.hs_table_name -- előélet listázása: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlViewSchemaHsTableName

-- DROP VIEW IF EXISTS schema.hs_table_name CASCADE;
CREATE OR REPLACE VIEW schema.hs_table_name AS
  SELECT
    e.id,
    e.eid,
    e.creation_time,
    e.creation_user,
    -- bob.get_user_name(e.creation_user,e.creation_time) AS creation_user_name,
    e.modification_time,
    e.modification_user,
    -- bob.get_user_name(e.modification_user,e.modification_time) AS modification_user_name,

    -- TODO e.field_name
  FROM schema.a_table_name AS e
  UNION
  SELECT
    e.id,
    e.eid,
    e.modification_time AS creation_time,
    e.modification_user AS creation_user,
    -- bob.get_user_name(e.modification_user,e.modification_time) AS creation_user_name,
    'infinity' AS modification_time,
    NULL AS modification_user,
    -- NULL AS modification_user_name,

    -- TODO e.field_name
  FROM schema.table_name AS e
  ORDER BY eid, creation_time;

GRANT SELECT
  ON TABLE schema.hs_table_name
  TO role_bob5admin;

-- END schema.hs_table_name.sql

