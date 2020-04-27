\connect @@CON@@

-- schema.select_table_name -- select lista: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlViewSchemaListTableName

-- DROP VIEW IF EXISTS schema.select_table_name CASCADE;
CREATE OR REPLACE VIEW schema.select_table_name AS
  SELECT
    e.eid,
    e.name
  FROM schema.table_name AS e
  WHERE e.is_active
    AND e.is_document_property
  ORDER BY e.priority;

GRANT SELECT
  ON TABLE schema.select_table_name
  TO role_bob5admin, role_bob5user;

-- END schema.select_table_name.sql
