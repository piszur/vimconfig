\connect @@CON@@

-- schema.undelete_table_name -- törlés visszavonása: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlFunctionSchemaUndeleteTableName

DROP FUNCTION IF EXISTS schema.undelete_table_name( bob.ref );
CREATE OR REPLACE FUNCTION schema.undelete_table_name(
  _EID bob.ref                                   -- egyedazonosító
) RETURNS integer AS $$                          -- rekordazonosító
DECLARE
  myTableNameID integer;
BEGIN

  SELECT
    e.id
  INTO
    myTableNameID
  FROM schema.ls_table_name AS e
  WHERE e.eid = _EID
    AND NOT e.is_active
  LIMIT 1;

  IF NOT FOUND THEN
    PERFORM bob.syslog('error','schema_undelete_table_name: missing_eid');
  END IF; -- IF NOT FOUND THEN

  UPDATE schema.table_name SET
    is_active = true
  WHERE id = myTableNameID;

  RETURN myTableNameID;
END;
$$ LANGUAGE plpgsql
EXTERNAL SECURITY DEFINER;
COMMENT ON FUNCTION schema.undelete_table_name( bob.ref ) IS 'törlés visszavonása: SCHEMA tabla_szerepenek_ismertetese.';

GRANT EXECUTE
  ON FUNCTION schema.undelete_table_name( bob.ref )
  TO role_bob5admin, role_bob5user;

-- END schema.undelete_table_name.sql

