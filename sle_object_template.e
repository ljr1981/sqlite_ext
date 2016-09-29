deferred class
	SLE_OBJECT_TEMPLATE

inherit
	SLE_INTERNAL

feature -- Access

	table_name: STRING
			--
		deferred
		end

	pk: STRING
			--
		deferred
		end

	fields: HASH_TABLE [TUPLE [type_code: INTEGER], STRING]
			--
		deferred
		end

	base_type: detachable SLE_PERSISTABLE
		deferred
		end

feature -- Basic Ops

	field_specifications (a_object: attached like base_type): ARRAY [TUPLE [name: STRING_8; type_code: INTEGER_32; is_asc: BOOLEAN]]
		local
			l_specs: ARRAYED_LIST [TUPLE [name: STRING_8; type_code: INTEGER_32; is_asc: BOOLEAN]]
		do
			create l_specs.make (20)
			across
				db_fields (a_object) as al_fld_specs
			loop
				if attached fields.item (al_fld_specs.item.field_name) as al_type_code then
					l_specs.force ([al_fld_specs.item.field_name, al_type_code.type_code, al_fld_specs.item.is_desc])
				end
			end
			Result := l_specs.to_array
		end

	db_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; is_desc: BOOLEAN; field_object: ANY]]
			-- Database fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.db)
		end

	primary_key_field_name (a_object: attached like base_type): STRING
		local
			l_list: ARRAYED_LIST [TUPLE [field_name: STRING; field_object: ANY]]
		do
			l_list := pk_fields (a_object)
			check has_one: l_list.count > 0 then
				Result := l_list [1].field_name
			end
		end

	pk_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; is_desc: BOOLEAN; field_object: ANY]]
			-- Primary key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.pk)
		end

	ck_fields (a_object: attached like base_type): ARRAYED_LIST [TUPLE [field_name: STRING; is_desc: BOOLEAN; field_object: ANY]]
			-- Candidate key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.ck)
		end

	fields_list (a_object: attached like base_type; a_extension: STRING): ARRAYED_LIST [TUPLE [field_name: STRING; is_desc: BOOLEAN; field_object: ANY]]
		local
			i: INTEGER
			l_field_name: STRING
			l_field_object: ANY
			l_parts: LIST [STRING]
		do
			i := reflector.field_count (a_object)
			check has_fields: i > 0 end
			create Result.make (i)
			across
				(1 |..| i) as ic
			loop
				l_field_name := reflector.field_name (ic.item, a_object)
				l_parts := l_field_name.split ('_')
				if attached reflector.field (ic.item, a_object) as al_field_object then
					if across l_parts as ic_ext_parts some ic_ext_parts.item.same_string (a_extension) end then
						Result.force ([l_field_name, across l_parts as ic_asc_parts some ic_asc_parts.item.same_string ("asc") end, al_field_object])
					end
				elseif l_field_name.same_string ({SLE_CONSTANTS}.created_on_db_field_name) then
					Result.force ([l_field_name, False, a_object.created_on_db])
				elseif l_field_name.same_string ({SLE_CONSTANTS}.modified_on_db_field_name) then
					Result.force ([l_field_name, False, a_object.modified_on_db])
				end
			end
		end

end
