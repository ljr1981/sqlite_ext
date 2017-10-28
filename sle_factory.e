note
	EIS: "src=http://sqlite.org/lang_createtable.html"

class
	SLE_FACTORY

inherit
	SLE_CONSTANTS

	LE_LOGGING_AWARE

feature -- QA/QC: PK/UUID/hash consistency/uniqueness

	test_uniqueness (a_table_spec, a_field_spec: STRING; a_value: INTEGER; a_db: SQLITE_DATABASE)
			-- Determine if `a_value' in `a_field_spec' of `a_table_spec' is unique in `a_db'?
		note
			design: "[
				This routine works with `on_is_unique_result' and `is_unique_count' to set up for `is_unique'.
				Call this routine when you need to know if an integer field value on a table is unique
				or not.
				]"
			history: "[
				Instead of using the generated integer IDs from the database, we use UUIDs and then
				hash them to an integer. The integer will only be unique 10-25% of the time, so this
				routine is here to provide feedback that the number is duplicated, and then force
				the caller to generate a new UUID --> new hash integer and test again and again until
				it is unique. This puts the responsibility of uniqueness on the code and not the database.
				The purpose of this is to protect against an edge case where the uniqueness of the PKs
				in the DB gets screwed up.
				
				NOTE: It is presumed that the UUID will also be stored in the DB so the veracity of the
				integer hash key can be validated (e.g. when the object is loaded back the loaded hash
				ought to match a regenerated hash from the UUID telling us that the data came back good).
				]"
		local
			lq: SQLITE_QUERY_STATEMENT
		do
			is_unique_count := 0
			create lq.make ("SELECT " + a_field_spec + " FROM " + a_table_spec + " WHERE " + a_field_spec + " = " + a_value.out + ";", a_db)
			lq.execute (agent on_is_unique_result)
		end

	is_unique: BOOLEAN
		do
			Result := is_unique_count = 0
		end

	is_unique_count: INTEGER

	on_is_unique_result (a_row: SQLITE_RESULT_ROW): BOOLEAN
		do
			is_unique_count := is_unique_count + 1
		end

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

	insert (a_object: SLE_PERSISTABLE; a_database: SQLITE_DATABASE)
		local
			l_insert: SLE_CREATE
			l_column_values: ARRAYED_LIST [TUPLE [col_name: STRING_8; col_value: STRING_8]]
			l_sql: STRING
		do
			create l_insert
			create l_column_values.make (10)
			across
				a_object.template.db_fields (a_object) as ic_specs
			loop
				if attached ic_specs.item.field_object as al_object then
					if (<<{SLE_CONSTANTS}.integer_type_code, {SLE_CONSTANTS}.real_type_code>>).has (ic_specs.item.type_code) then
						l_column_values.force ([ic_specs.item.field_name, al_object.out])
					else
						l_column_values.force ([ic_specs.item.field_name, "'" + al_object.out + "'"])
					end
				end
			end
			l_insert.insert (a_database, a_object.table_name, l_column_values.to_array)
		end

	create_new_table_from_template (a_database: SQLITE_DATABASE; a_object: SLE_PERSISTABLE; a_template: SLE_OBJECT_TEMPLATE)
		local
			l_modify: SQLITE_MODIFY_STATEMENT
		do
			create l_modify.make (generate_new_table_from_template_sql (a_object, a_template), a_database)
			l_modify.execute
		end

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

	generate_new_table_from_template_sql (a_object: SLE_PERSISTABLE; a_template: SLE_OBJECT_TEMPLATE): STRING
		do
			Result := generate_new_table_sql (a_object.table_name, a_template.primary_key_field_name (a_object), a_template.field_specifications (a_object))
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
			Result.append_string_general (integer_primary_key_field (a_pk))
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

	integer_primary_key_field (a_name: STRING): STRING
		do
			Result := a_name
			Result.append_string_general (" INTEGER ")
			Result.append_string_general (" PRIMARY KEY ")
			Result.append_string_general (asc_or_desc (True))
			Result.append_string_general (" AUTOINCREMENT ")
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
