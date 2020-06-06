deferred class
	SLE_CRUD

inherit
	LE_LOGGING_AWARE

feature -- Access: All

	clear_all do clear_database; clear_table_name; clear_columns end

	clear_table_and_columns do clear_table_name; clear_columns end

feature -- Access: Database

	database: detachable SQLITE_DATABASE

	database_attached: attached like database do check has: attached database as al_item then Result := al_item end end

	clear_database do database := Void end

	set_database (a_db: attached like database) do database := a_db end

feature -- Access: Table Name

	table_name: detachable STRING

	table_name_attached: attached like table_name do check has: attached table_name as al_item then Result := al_item end end

	clear_table_name do table_name := Void end

	set_table_name (a_name: attached like table_name) do table_name := a_name end

feature -- Access: Columns

	columns: ARRAYED_LIST [TUPLE [col_name, col_value: STRING]] attribute create Result.make (100) end

	column_names: ARRAYED_LIST [STRING]
		do
			create Result.make (columns.count)
			across
				columns as ic
			loop
				Result.force (ic.item.col_name)
			end
		end

	columns_as_array: ARRAY [TUPLE [col_name, col_value: STRING]] do Result := columns.to_array end

	column_names_as_array: ARRAY [STRING] do Result := column_names.to_array end

	clear_columns do columns.wipe_out end

	set_columns (a_columns: ARRAY [TUPLE [col_name, col_value: STRING]])
		do
			across
				a_columns as ic
			loop
				columns.force (ic.item)
			end
		end

feature -- Access: Where

	where: detachable STRING

	where_attached: attached like where do check has: attached where as al_item then Result := al_item end end

	clear_where do where := Void end

	set_where (a_item: attached like where) do where := a_item end

feature -- Operations

	execute_on_settings
			-- `do' from attribute settings
		require
			has_database: attached database
			has_table_name: attached table_name
			has_columns: not columns.is_empty
		deferred
		end

feature -- Settings

	is_insert_only: BOOLEAN

	is_update_only: BOOLEAN

	is_select_only: BOOLEAN

	is_replace_only: BOOLEAN

	is_insert_or_replace: BOOLEAN

	is_insert_or_rollback: BOOLEAN

	is_insert_or_abort: BOOLEAN

	is_insert_or_fail: BOOLEAN

	is_insert_or_ignore: BOOLEAN

feature -- Setters

	reset_all
		do
			is_insert_only := False
			is_update_only := False
			is_select_only := False
			is_replace_only := False
			is_insert_or_replace := False
			is_insert_or_rollback := False
			is_insert_or_abort := False
			is_insert_or_fail := False
			is_insert_or_ignore := False
		end

	set_is_insert_only (a_is_insert_only: like is_insert_only)
			-- Sets `is_insert_only' with `a_is_insert_only'.
		do
			reset_all
			is_insert_only := a_is_insert_only
		ensure
			is_insert_only_set: is_insert_only = a_is_insert_only
		end

	set_is_update_only (a_is_update_only: like is_update_only)
			-- Sets `set_is_update_only' with `a_is_update_only'.
		do
			reset_all
			is_update_only := a_is_update_only
		ensure
			is_update_only_set: is_update_only = a_is_update_only
		end

	set_is_select_only (a_is_select_only: like is_select_only)
			-- Sets `set_is_select_only' with `a_is_select_only'.
		do
			reset_all
			is_select_only := a_is_select_only
		ensure
			is_select_only_set: is_select_only = a_is_select_only
		end

	set_is_replace_only (a_is_replace_only: like is_replace_only)
			-- Sets `is_replace_only' with `a_is_replace_only'.
		do
			reset_all
			is_replace_only := a_is_replace_only
		ensure
			is_replace_only_set: is_replace_only = a_is_replace_only
		end

	set_is_insert_or_replace (a_is_insert_or_replace: like is_insert_or_replace)
			-- Sets `is_insert_or_replace' with `a_is_insert_or_replace'.
		do
			reset_all
			is_insert_or_replace := a_is_insert_or_replace
		ensure
			is_insert_or_replace_set: is_insert_or_replace = a_is_insert_or_replace
		end

	set_is_insert_or_rollback (a_is_insert_or_rollback: like is_insert_or_rollback)
			-- Sets `is_insert_or_rollback' with `a_is_insert_or_rollback'.
		do
			reset_all
			is_insert_or_rollback := a_is_insert_or_rollback
		ensure
			is_insert_or_rollback_set: is_insert_or_rollback = a_is_insert_or_rollback
		end

	set_is_insert_or_abort (a_is_insert_or_abort: like is_insert_or_abort)
			-- Sets `is_insert_or_abort' with `a_is_insert_or_abort'.
		do
			reset_all
			is_insert_or_abort := a_is_insert_or_abort
		ensure
			is_insert_or_abort_set: is_insert_or_abort = a_is_insert_or_abort
		end

	set_is_insert_or_fail (a_is_insert_or_fail: like is_insert_or_fail)
			-- Sets `is_insert_or_fail' with `a_is_insert_or_fail'.
		do
			reset_all
			is_insert_or_fail := a_is_insert_or_fail
		ensure
			is_insert_or_fail_set: is_insert_or_fail = a_is_insert_or_fail
		end

	set_is_insert_or_ignore (a_is_insert_or_ignore: like is_insert_or_ignore)
			-- Sets `is_insert_or_ignore' with `a_is_insert_or_ignore'.
		do
			reset_all
			is_insert_or_ignore := a_is_insert_or_ignore
		ensure
			is_insert_or_ignore_set: is_insert_or_ignore = a_is_insert_or_ignore
		end

end
