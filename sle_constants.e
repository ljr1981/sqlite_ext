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

	integer_type_code: INTEGER = 1
	text_type_code: INTEGER = 2
	boolean_type_code: INTEGER = 3
	date_type_code: INTEGER = 4

	create_table_kw: STRING = " CREATE TABLE "

	If_not_exists_kw_phrase: STRING_8 = " IF NOT EXISTS "

	open_paren: CHARACTER = '('
	close_paren: CHARACTER = ')'
	comma: CHARACTER = ','
	closing_semi_colon: CHARACTER = ';'
	space: CHARACTER = ' '

end
