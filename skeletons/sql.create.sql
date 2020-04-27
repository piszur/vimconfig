\connect @@CON@@

-- schema.create_table_name -- létrehozás: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlFunctionSchemaCreateTableName

DROP FUNCTION IF EXISTS schema.create_table_name( TODO field_type );
CREATE OR REPLACE FUNCTION schema.create_table_name(
  -- TODO _FieldName field_type
) RETURNS integer AS $$                          -- egyed, illetve rekordazonosító
DECLARE
  myTableNameID bob.ref;
BEGIN

  INSERT INTO schema.table_name (
    -- TODO field_name
  ) VALUES (
    -- TODO _FieldName
  ) RETURNING id INTO myTableNameID;

  RETURN myTableNameID;
END;
$$ LANGUAGE plpgsql
EXTERNAL SECURITY DEFINER;
COMMENT ON FUNCTION schema.create_table_name( TODO field_type ) IS 'létrehozás: SCHEMA tabla_szerepenek_ismertetese';

GRANT EXECUTE
  ON FUNCTION schema.create_table_name( TODO field_type )
  TO role_bob5admin, role_bob5user;

-- END schema.create_table_name.sql


