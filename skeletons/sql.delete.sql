\connect @@CON@@

-- schema.delete_table_name -- törlés: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlFunctionSchemaDeleteTableName

DROP FUNCTION IF EXISTS schema.delete_table_name( bob.ref );
CREATE OR REPLACE FUNCTION schema.delete_table_name(
  _EID bob.ref                                   -- egyedazonosító
) RETURNS integer AS $$                          -- rekordazonosító

DECLARE
  myTableNameID integer;                        -- 'table_name rekordazonosítója'
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
    PERFORM bob.syslog('error','schema_delete_table_name: missing_eid');
  END IF; -- IF NOT FOUND THEN

  UPDATE schema.table_name SET
    is_active = false
  WHERE id = myTableNameID;

  RETURN myTableNameID;
END;
$$ LANGUAGE plpgsql
EXTERNAL SECURITY DEFINER;
COMMENT ON FUNCTION schema.delete_table_name( bob.ref ) IS 'törlés: SCHEMA tabla_szerepenek_ismertetese';

GRANT EXECUTE
  ON FUNCTION schema.delete_table_name( bob.ref )
  TO role_bob5admin;

-- END schema.delete_table_name.sql

