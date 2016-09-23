class
	SLE_CONSTANTS

feature -- Constants

	is_asc: BOOLEAN = True
	not_is_asc: BOOLEAN = False
	is_distinct: BOOLEAN = True

	asc_code: STRING = "ASC"
	not_asc_code: STRING = "NOT_ASC"

feature -- SQL String Constants

	insert_kw: STRING = " INSERT "
	update_kw: STRING = " UPDATE "
	select_kw: STRING = " SELECT "

	distinct_kw: STRING = " DISTINCT "
	all_kw: STRING = " ALL "
	from_kw: STRING = " FROM "
	join_kw: STRING = " JOIN "
	on_kw: STRING = " ON "
	group_kw: STRING = " GROUP "
	by_kw: STRING = " BY "
	group_by_kw: STRING = " GROUP BY "
	having_kw: STRING = " HAVING "
	order_kw: STRING = " ORDER "
	order_by_kw: STRING = " ORDER BY "
	limit_kw: STRING = " LIMIT "
	with_kw: STRING = " WITH "
	recursive_kw: STRING = " RECURSIVE "
	offset_kw: STRING = " OFFSET "
	replace_kw: STRING = " REPLACE "
	rollback_kw: STRING = " ROLLBACK "
	abort_kw: STRING = " ABORT "
	fail_kw: STRING = " FAIL "
	ignore_kw: STRING = " IGNORE "
	into_kw: STRING = " INTO "

	values_kw: STRING = " VALUES "
	set_kw: STRING = " SET "
	where_kw: STRING = " WHERE "
	or_kw: STRING = " OR "


	null_type_code: INTEGER = 0
			--NULL. The value is a NULL value.

	integer_type_code: INTEGER = 1
			--INTEGER. The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.

	real_type_code: INTEGER = 2
			--REAL. The value is a floating point value, stored as an 8-byte IEEE floating point number.

	text_type_code: INTEGER = 3
	boolean_type_code: INTEGER = 4
	date_type_code: INTEGER = 5
			--TEXT. The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).

	blob_type_code: INTEGER = 6
			--BLOB. The value is a blob of data, stored exactly as it was input.

	create_table_kw: STRING = " CREATE TABLE "

	If_not_exists_kw_phrase: STRING_8 = " IF NOT EXISTS "

	open_paren: CHARACTER = '('
	close_paren: CHARACTER = ')'
	comma: CHARACTER = ','
	closing_semi_colon: CHARACTER = ';'
	space: CHARACTER = ' '

	db: STRING = "_db"
	pk: STRING = "_pk"
	ck: STRING = "_ck"
	created_on_db_field_name: STRING = "created_on_db"
	modified_on_db_field_name: STRING = "modified_on_db"

end
