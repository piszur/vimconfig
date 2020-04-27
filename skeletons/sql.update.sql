\connect @@CON@@

-- schema.update_table_name -- módosítás: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlFunctionSchemaUpdateTableName

DROP FUNCTION IF EXISTS schema.update_table_name( bob.ref, TODO field_type );
CREATE OR REPLACE FUNCTION schema.update_table_name(
  _EID bob.ref,
  -- TODO _FieldName field_type
) RETURNS integer AS $$                          -- rekordazonosító
DECLARE
  myTableNameID integer;
  tmpID bob.ref;
BEGIN

  SELECT
    e.id
  INTO
    myTableNameID
  FROM schema.ls_table_name AS e
  WHERE e.eid = _EID
    AND e.is_active
  LIMIT 1;

  IF NOT FOUND THEN
    PERFORM bob.syslog('error','schema_update_table_name: missing_eid');
  END IF; -- IF NOT FOUND THEN

  UPDATE schema.table_name SET
    -- TODO field_name = _FieldName,
  WHERE id = myTableNameID;

  RETURN myTableNameID;
END;
$$ LANGUAGE plpgsql
EXTERNAL SECURITY DEFINER;
COMMENT ON FUNCTION schema.update_table_name( bob.ref, TODO field_type ) IS 'módosítás: SCHEMA tabla_szerepenek_ismertetese';

GRANT EXECUTE
  ON FUNCTION schema.update_table_name( bob.ref, TODO field_type )
  TO role_bob5admin, role_bob5user;

-- END schema.update_table_name.sql

