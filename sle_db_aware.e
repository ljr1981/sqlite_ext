deferred class
	SLE_DB_AWARE

inherit
	SLE_ANY
		undefine
			default_create
		end

feature -- Constants

	db_file_name: STRING
			--
		deferred
		end

feature -- Basic Ops

	create_alt_db_path (a_path: PATH)
			--	`create_alt_db_path' based on `a_path' and `db_file_name'.
		do
			create internal_db_path.make_from_string (a_path.absolute_path.name.out + "\" + db_file_name)
		end

	create_db_path
			-- `create_db_path' based on `db_file_name' and {EXECUTION_ENVIRONMENT}.current_working_path.
		local
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			create internal_db_path.make_from_string (l_env.current_working_path.absolute_path.name.out + "\" + db_file_name)
		end

feature {NONE} -- Implementation

	db_path: PATH
			--
		once
			check has_path: attached internal_db_path as al_db_path then
				Result := al_db_path
			end
		end

	db_factory: SLE_FACTORY
			--
		once
			create Result
		end

	database: SQLITE_DATABASE
			--
		once
			create Result.make_create_read_write (db_path.absolute_path.name.out)
		end

	internal_db_path: detachable PATH
			-- `internal_db_path' as optional `database' {PATH}.

end
