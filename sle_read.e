note
	EIS: "src=http://sqlite.org/lang_select.html"

class
	SLE_READ

inherit
	SLE_CRUD
		redefine
			default_create
		end

	SLE_CONSTANTS
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			is_select_only := True
		end

feature -- Basic Ops

	generate_select_distinct_sql (a_table_name: STRING; a_columns: ARRAY [STRING]; a_src_tables: ARRAY [TUPLE [table_name: STRING; join, on: detachable STRING]]): STRING
		do
			Result := generate_base_select_something_where_sql (a_table_name, is_distinct, a_columns, a_src_tables, Void)
		end

	generate_select_distinct_where_sql (a_table_name: STRING; a_columns: ARRAY [STRING]; a_src_tables: ARRAY [TUPLE [table_name: STRING; join, on: detachable STRING]]; a_where: detachable STRING): STRING
		do
			Result := generate_base_select_something_where_sql (a_table_name, is_distinct, a_columns, a_src_tables, a_where)
		end

	generate_select_all_sql (a_table_name: STRING; a_is_distinct: BOOLEAN; a_src_tables: ARRAY [TUPLE [table_name: STRING; join, on: detachable STRING]]): STRING
		do
			Result := generate_base_select_something_where_sql (a_table_name, a_is_distinct, <<all_kw>>, a_src_tables, Void)
		end

	generate_select_all_where_sql (a_table_name: STRING; a_is_distinct: BOOLEAN; a_src_tables: ARRAY [TUPLE [table_name: STRING; join, on: detachable STRING]]; a_where: detachable STRING): STRING
		do
			Result := generate_base_select_something_where_sql (a_table_name, a_is_distinct, <<all_kw>>, a_src_tables, a_where)
		end

	generate_base_select_something_where_sql (a_table_name: STRING; a_is_distinct: BOOLEAN; a_columns: ARRAY [STRING]; a_src_tables: ARRAY [TUPLE [table_name: STRING; join, on: detachable STRING]]; a_where: detachable STRING): STRING
			-- `generate_base_select_something_where_sql'.
			--	For example: "SELECT DISTINCT|ALL <<RESULT_COLUMN>> [, ...] FROM <<TABLE_OR_SUBQUERY>> [<<JOIN>>] [, ...] [WHERE <<EXPRESSION>>] [GROUP BY <<EXPRESSIONS>> [HAVING <<EXPRESSION>>]] "
		do
			create Result.make_empty
			Result.append_string_general (select_kw)
			if a_is_distinct then
				Result.append_string_general (distinct_kw)
			end
			across
				a_columns as ic
			loop
				Result.append_string_general (ic.item)
				Result.append_character (comma)
			end
			Result.remove_tail (1)
			Result.append_character (space)
			Result.append_string_general (from_kw)
			across
				a_src_tables as ic
			loop
				Result.append_string_general (ic.item.table_name)
				if attached ic.item.join as al_join then
					Result.append_string_general (join_kw)
					Result.append_string_general (al_join)
					if attached ic.item.on as al_on then
						Result.append_string_general (on_kw)
						Result.append_string_general (al_on)
					end
				end
				Result.append_character (space)
			end
			if attached a_where as al_where then
				Result.append_string_general (where_kw)
				Result.append_string_general (al_where)
			end
		end

end
