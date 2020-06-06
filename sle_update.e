class
	SLE_UPDATE

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
			is_update_only := True
		end

feature -- Basic Ops

	execute_on_settings
			-- `insert' from attribute settings
		do
			execute (database_attached, table_name_attached, columns_as_array, where)
		end

	execute (a_database: like database; a_table_name: STRING; a_column_values: ARRAY [TUPLE [col_name, col_expression: STRING]]; a_where: detachable STRING)
			--
		local
			l_modify: SQLITE_MODIFY_STATEMENT
			l_sql: STRING
		do
			l_sql := generate_update_sql (a_table_name, a_column_values, a_where)
			logger.write_information (l_sql)
			create l_modify.make (l_sql, database_attached)
			l_modify.execute
		end

	generate_update_sql (a_table_name: STRING; a_column_values: ARRAY [TUPLE [col_name, col_expression: STRING]]; a_where: detachable STRING): STRING
			-- For example: UPDATE <<TABLE_NAME>> SET <<COLUMN_NAME>> = <<EXPRESSION>>, [ ... ] WHERE <<EXPRESSION>>
		do
			create Result.make_empty
			Result.append_string_general (update_kw)
			Result.append_string_general (a_table_name)
			Result.append_character (space)
			across
				a_column_values as ic
			loop
				Result.append_string_general (ic.item.col_name)
				Result.append_character ('=')
				Result.append_string_general (ic.item.col_expression)
				Result.append_character (comma)
			end
			Result.remove_tail (1)
			Result.append_character (space)
			if attached a_where as al_where and then not al_where.is_empty then
				Result.append_string_general (where_kw)
				Result.append_string_general (al_where)
			end
			Result.append_character (closing_semi_colon)
		end

end
