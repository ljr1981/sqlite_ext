note
	EIS: "src=http://sqlite.org/lang_createtable.html"

class
	SLE_FACTORY

inherit
	SLE_CONSTANTS

feature -- Database

	create_new_database (a_path: detachable PATH): SQLITE_DATABASE
			-- `create_new_data' in `a_path', `path', or with `current_working_path' from {EXECUTION_ENVIRONMENT}
		local
			l_env: EXECUTION_ENVIRONMENT
		do
			if attached a_path as al_path then
				create Result.make_create_read_write (al_path.name.out)
			elseif attached path as al_internal_path then
				create Result.make_create_read_write (al_internal_path.name.out)
			else
				create l_env
				create Result.make_create_read_write (l_env.current_working_path.name.out)
			end
		end

	set_path (a_path: PATH)
			-- `set_path' with `a_path' for optional `path' for `create_new_database'.
		do
			path := a_path
		ensure
			set: path ~ a_path
		end

	path: detachable PATH
			-- Optional `path' for `create_new_database'.

feature -- Table

	create_new_table (a_database: SQLITE_DATABASE; a_table_name, a_pk: STRING; a_fields: ARRAY [TUPLE [name: STRING; type_code: INTEGER; is_asc: BOOLEAN]])
			-- `create_new_table' in `a_database' as `a_table_name' with `a_pk' field and then `a_fields' as needed.
		local
			l_modify: SQLITE_MODIFY_STATEMENT
			l_sql: STRING
		do
			l_sql := generate_new_table_sql (a_table_name, a_pk, a_fields)
			create l_modify.make (l_sql, a_database)
			l_modify.execute
		end


	generate_new_table_sql (a_table_name, a_pk: STRING; a_fields: ARRAY [TUPLE [name: STRING; type_code: INTEGER; is_asc: BOOLEAN]]): STRING
			-- `generate_new_table_sql' for `create_new_table'.
		note
			EIS: "src=http://sqlite.org/lang_createtable.html"
		do
			create Result.make_empty
			Result.append_string_general (create_table_kw)
			Result.append_string_general (if_not_exists_kw_phrase)
			Result.append_string_general (a_table_name)
			Result.append_character (space)
			Result.append_character (open_paren)
			Result.append_string_general (integer_primary_key_field (a_pk, True, False))
			Result.append_character (comma)
			Result.append_character (space)
			across
				a_fields as ic_fields
			loop
				inspect
					ic_fields.item.type_code
				when integer_type_code then
					Result.append_string_general (integer_field (ic_fields.item.name, ic_fields.item.is_asc))
				when text_type_code then
					Result.append_string_general (text_field (ic_fields.item.name, ic_fields.item.is_asc))
				when boolean_type_code then
					Result.append_string_general (boolean_field (ic_fields.item.name, ic_fields.item.is_asc))
				when date_type_code then
					Result.append_string_general (date_field (ic_fields.item.name, ic_fields.item.is_asc))
				else
					check unknown_field_type: False end
				end
				Result.append_character (comma)
			end
			Result.remove_tail (1)
			Result.append_character (close_paren)
			Result.append_character (closing_semi_colon)
		end

feature -- Fields

	integer_field (a_name: STRING; a_is_asc: BOOLEAN): STRING
			-- `integer_field' creation string for `a_name' as `a_is_asc' (or not).
			-- See {SLE_CONSTANTS} for setting possibilities of `a_is_asc' to make
			-- code more readable (i.e. call as: `integer_field' ("my_name", {SLE_CONSTANTS}.is_asc))
		do
			Result := field (a_name, " INTEGER ", a_is_asc)
		end

	integer_primary_key_field (a_name: STRING; a_is_asc, a_auto_increment: BOOLEAN): STRING
		do
			Result := a_name
			Result.append_string_general (" PRIMARY KEY ")
			Result.append_string_general (asc_or_desc (a_is_asc))
			if a_auto_increment then
				Result.append_string_general (" AUTOINCREMENT ")
			end
		end

	text_field (a_name: STRING; a_is_asc: BOOLEAN): STRING
		do
			Result := field (a_name, " TEXT ", a_is_asc)
		end

	boolean_field (a_name: STRING; a_is_asc: BOOLEAN): STRING
		do
			Result := integer_field (a_name, a_is_asc)
		end

	date_field (a_name: STRING; a_is_asc: BOOLEAN): STRING
		do
			Result := text_field (a_name, a_is_asc)
		end

	field (a_name, a_type: STRING; a_is_asc: BOOLEAN): STRING
		do
			Result := a_name
			Result.append_string_general (a_type)
			Result.append_string_general (asc_or_desc (a_is_asc))
		end

	asc_or_desc (a_is_asc: BOOLEAN): STRING
		do
			create Result.make_empty
			if a_is_asc then
				Result.append_string_general (" ASC ")
			else
				Result.append_string_general (" DESC ")
			end
		end

end
