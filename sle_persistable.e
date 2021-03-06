deferred class
	SLE_PERSISTABLE

feature -- Access

	table_name: STRING
			-- `table_name' used to persist instances of Current to a database.
		deferred
		end

	created_on_db: DATE_TIME attribute create Result.make_now end
			-- The `created_on_db' date-time that Current was created in the database.

	modified_on_db: DATE_TIME attribute create Result.make_now end
			-- The `modified_on_db' last date-time of modification of Current and persisted to the database.

	template: attached like internal_template
			-- Attached version of `internal_template'.
		do
			if attached internal_template as al_template then
				Result := al_template
			else
				create_template
				check attached internal_template as al_template then Result := al_template end
			end
		end

	internal_template: detachable SLE_OBJECT_TEMPLATE
			-- The `internal_template' used to interact with the database.
		deferred
		end

	create_template
		deferred
		end

end
