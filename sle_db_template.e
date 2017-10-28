deferred class
	SLE_DB_TEMPLATE [G -> ANY]

inherit
	SLE_OBJECT_TEMPLATE

	SLE_PERSISTABLE

feature {NONE} -- Initialization

	make_with_object (a_object: G)
		do
			set_with_object (a_object)
		end

feature -- Setters & Resetters

	set_with_object (a_object: G)
			-- Sets persistable fields from `a_object' into local template fields.
			-- This is in prep for persisting from the database.
		deferred
		end

	reset
			-- Reset Current to default state.
		deferred
		end

	on_query_result (a_row: SQLITE_RESULT_ROW): BOOLEAN
			-- Each row in the query result triggers a call
			-- to this routine. So, we create a result
			-- `l_item', populate it from the row and
			-- stick that object in the `query_results'.
		deferred
		end

	query_results: ARRAYED_LIST [G]
		attribute
			create Result.make (100)
		end

feature -- Access

	primary_key_field_name_string: STRING = "id"
			-- Name of the primary key field as a string.

	item_anchor: detachable G

feature -- New Table Specs

	new_table_spec: ARRAY [TUPLE [name: STRING_8; type_code: INTEGER_32; is_asc: BOOLEAN]]
		deferred
		end

feature {NONE} -- Implementation

	base_type: SLE_PERSISTABLE
			-- <Precursor>
		attribute
			Result := Current
		end

	internal_template: SLE_OBJECT_TEMPLATE
			-- <Precursor>
		attribute
			Result := Current
		end

	create_template
			-- <Precursor>
		do
			internal_template := Current
		end

end
