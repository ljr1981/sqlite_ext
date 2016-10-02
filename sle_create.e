note
	EIS: "src=http://sqlite.org/lang_insert.html"

class
	SLE_CREATE

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
			is_insert_only := True
		end

feature -- Basic Ops

	insert (a_database: SQLITE_DATABASE; a_table_name: STRING; a_column_values: ARRAY [TUPLE [col_name, col_value: STRING]])
			--
		local
			l_modify: SQLITE_MODIFY_STATEMENT
			l_sql: STRING
		do
			l_sql := generate_insert_sql (a_table_name, a_column_values)
			logger.write_information (l_sql)
			create l_modify.make (l_sql, a_database)
			l_modify.execute
		end

	generate_insert_sql (a_table_name: STRING; a_column_values: ARRAY [TUPLE [col_name, col_value: STRING]]): STRING
			-- `generate_insert_sql' for `a_table_name' and `a_column_values' list.
			--	For example: "INSERT INTO <<TABLE_NAME>> (<<COLUMNS>>) VALUES (<<EXPRESSIONS>>)"
		local
			l_cols,
			l_vals: STRING
		do
			create Result.make_empty
			if is_insert_only then
				Result.append_string_general (insert_kw)
			else
				check unknown_command: False end
			end
			Result.append_string_general (into_kw)
			Result.append_string_general (a_table_name)
			Result.append_character (space)

			create l_cols.make_filled (open_paren, 1)
			create l_vals.make_filled (open_paren, 1)

			across
				a_column_values as ic
			loop
				l_cols.append_string_general (ic.item.col_name)
				l_cols.append_character (comma)
				l_vals.append_string_general (ic.item.col_value)
				l_vals.append_character (comma)
			end

			l_cols.remove_tail (1)
			l_vals.remove_tail (1)
			l_cols.append_character (close_paren)
			l_vals.append_character (close_paren)

			Result.append_string_general (l_cols)
			Result.append_string_general (values_kw)
			Result.append_string_general (l_vals)

			Result.append_character (closing_semi_colon)
		end

end
