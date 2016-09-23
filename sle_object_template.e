deferred class
	SLE_OBJECT_TEMPLATE

inherit
	SLE_INTERNAL

feature -- Access

	pk: STRING
			--
		deferred
		end

	fields: ARRAYED_LIST [STRING]
			--
		deferred
		end

	base_type: detachable SLE_PERSISTABLE
		deferred
		end

feature -- Basic Ops

	db_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; field_object: ANY]]
			-- Database fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.db)
		end

	pk_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; field_object: ANY]]
			-- Primary key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.pk)
		end

	ck_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; field_object: ANY]]
			-- Candidate key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.ck)
		end

	fields_list (a_object: attached like base_type; a_extension: STRING): ARRAYED_LIST [TUPLE [field_name: STRING; field_object: ANY]]
		local
			i,j: INTEGER
			l_field_name,
			l_tail: STRING
			l_field_object: ANY
		do
			i := reflector.field_count (a_object)
			create Result.make (i)
			across
				(1 |..| i) as ic
			loop
				j := ic.item
				l_field_name := reflector.field_name (j, a_object)
				if attached reflector.field (j, a_object) as al_object then
					l_field_object := al_object
					l_tail := l_field_name.substring (l_field_name.count - a_extension.count + 1, l_field_name.count)
					if l_tail.same_string (a_extension) then
						Result.force ([l_field_name, l_field_object])
					end
				elseif l_field_name.same_string ({SLE_CONSTANTS}.created_on_db_field_name) then
					Result.force ([l_field_name, a_object.created_on_db])
				elseif l_field_name.same_string ({SLE_CONSTANTS}.modified_on_db_field_name) then
					Result.force ([l_field_name, a_object.modified_on_db])
				end
			end
		end

end
