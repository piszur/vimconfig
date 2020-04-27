\connect @@CON@@

-- schema.search_table_name -- automplete alapértelmezett lista: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlViewSchemaSearchTableName


DROP FUNCTION IF EXISTS schema.search_table_name();
CREATE OR REPLACE FUNCTION schema.search_table_name()
RETURNS TABLE (priority bigint, eid bob.ref, tag varchar) AS $$
  SELECT
		CAST( DATE_PART('milliseconds', now() - e.modification_time ) AS bigint ) AS priority,
    e.eid,
		e.tag
  FROM schema.list_table_name AS e
  WHERE e.user_id = bob.get_current_user_id()
    AND is_active
	ORDER BY modification_time DESC
$$ LANGUAGE SQL;
COMMENT ON FUNCTION schema.search_table_name() IS 'automplete alapértelmezett lista: SCHEMA tabla_szerepenek_ismertetese';

GRANT EXECUTE
  ON FUNCTION schema.search_table_name()
  TO role_bob5admin, role_bob5user;

-- GRANT SELECT
--   ON TABLE schema.search_table_name
--   TO role_bob5admin, role_bob5user;

-- END schema.search_table_name.sql

