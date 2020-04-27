\connect @@CON@@

-- schema.table_name -- SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlTableSchemaTableName

-- DROP TABLE IF EXISTS schema.table_name CASCADE;
CREATE TABLE schema.table_name (
  id serial NOT NULL,
  eid bob.ref,
  is_active boolean NOT NULL DEFAULT true,
  creation_time timestamp with time zone NOT NULL DEFAULT now(),
  creation_user bob.ref NOT NULL,
  modification_time timestamp with time zone,
  modification_user bob.ref,
  -- todo további mezők
);

COMMENT ON TABLE schema.table_name IS 'SCHEMA tabla_szerepenek_ismertetese';
COMMENT ON COLUMN schema.table_name.id IS 'rekordazonosító';
COMMENT ON COLUMN schema.table_name.eid IS 'egyed azonosítója';
COMMENT ON COLUMN schema.table_name.is_active IS 'egyed aktív (true) vagy törölt (false)';
COMMENT ON COLUMN schema.table_name.creation_time IS 'egyed létrehozásának időpontja';
COMMENT ON COLUMN schema.table_name.creation_user IS 'egyedet létrehozó felhasználó';
COMMENT ON COLUMN schema.table_name.modification_time IS 'utolsó módosítás időpontja';
COMMENT ON COLUMN schema.table_name.modification_user IS 'utoljára módosító felhasználó';
-- todo további megjegyzések

ALTER TABLE ONLY schema.table_name
  ADD CONSTRAINT table_name_pkey
  PRIMARY KEY (id);

ALTER TABLE ONLY schema.table_name
  ADD CONSTRAINT table_name_dates_check
  CHECK (creation_time <= modification_time);

ALTER TABLE ONLY schema.table_name
  ADD CONSTRAINT table_name_eid_fkey
  FOREIGN KEY (eid)
  REFERENCES schema.table_name(id)
  ON UPDATE RESTRICT
  ON DELETE RESTRICT;

ALTER TABLE ONLY schema.table_name
  ADD CONSTRAINT table_name_id_eid_check
  CHECK (id = eid);

-- todo további szabályok (foreign_key, check, unique vagy exclude, stb.)

CREATE TRIGGER triggerbefore_table_name_bob
  BEFORE INSERT OR UPDATE OR DELETE
  ON schema.table_name FOR EACH ROW
  EXECUTE PROCEDURE bob.trigger();

CREATE TRIGGER triggerafter_table_name_bob
  AFTER INSERT OR UPDATE OR DELETE
  ON schema.table_name FOR EACH ROW
  EXECUTE PROCEDURE bob.trigger();

-- DROP RULE IF EXISTS delete_table_name ON schema.table_name CASCADE;
CREATE RULE delete_table_name AS ON
  DELETE TO schema.table_name
  DO INSTEAD
  UPDATE schema.table_name SET
    is_active = false
  WHERE eid = OLD.eid
  RETURNING OLD.*;

-- END 0000_00.schema.table_name.sql
