\connect @@CON@@

-- schema.search_table_name -- automplete keresés: SCHEMA tabla_szerepenek_ismertetese
-- https://wiki.mithrandir.hu/foswiki/bin/view/SchemaDocHu/SchemaSqlViewSchemaSearchTableName

-- DROP FUNCTION IF EXISTS schema.search_table_name( varchar );
CREATE OR REPLACE FUNCTION schema.search_table_name(
  _Tag varchar
) RETURNS TABLE (priority bigint, eid bob.ref, tag varchar) AS $$
	WITH
		e AS (
			SELECT
				*
			FROM schema.list_table_name AS e
			WHERE e.user_id = bob.get_current_user_id()
				AND is_active
		)
	SELECT
		CAST( 0 AS bigint ) AS priority,
    e.eid,
		e.tag
	FROM e
	WHERE e.tag = _Tag
	UNION
	SELECT
		CAST( 1 AS bigint ) AS priority,
    e.eid,
		e.tag
	FROM e
	WHERE e.tag ILIKE _Tag || '%'
		AND e.tag != _Tag
	UNION
	SELECT
		CAST( 2 AS bigint ) AS priority,
    e.eid,
		e.tag
	FROM e
	WHERE e.tag ILIKE '%' || _Tag || '%'
		AND e.tag NOT ILIKE _Tag || '%'
		AND e.tag != _Tag
	UNION
	SELECT
		CAST( 3 AS bigint ) AS priority,
    e.eid,
		e.tag
	FROM e
	WHERE soundex(e.tag) = soundex(_Tag)
		AND e.tag NOT ILIKE '%' || _Tag || '%'
		AND e.tag != _Tag
	ORDER BY priority, tag;
$$ LANGUAGE SQL;
COMMENT ON FUNCTION schema.search_table_name( varchar ) IS 'automplete keresés: SCHEMA tabla_szerepenek_ismertetese';

GRANT EXECUTE
  ON FUNCTION schema.search_table_name( varchar )
  TO role_bob5admin, role_bob5user;

-- END schema.search_table_name.sql

