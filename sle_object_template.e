deferred class
	SLE_OBJECT_TEMPLATE

inherit
	SLE_INTERNAL

feature -- Access

	primary_key_field_name (a_object: attached like base_type): STRING
			-- `primary_key_field_name' of Current `a_object' `base_type'.
		do
			check attached pk_fields (a_object) [1] as al_pk_spec then
				Result := al_pk_spec.field_name
			end
		end

	base_type: detachable SLE_PERSISTABLE
			-- `base_type' controls access to the features of this template.
		deferred
		end

feature -- Basic Ops

	field_specifications (a_object: attached like base_type): ARRAY [TUPLE [name: STRING_8; type_code: INTEGER_32; is_asc: BOOLEAN]]
			-- `field_specifications' of `a_object' like `base_type', resulting in:
			-- TUPLE [name, type_code, is_asc]
			-- Where name is the field-name stored in the database and type_code controls
			-- what datatype is used. The is_asc controls if the ordering is ASC or DESC.
		local
			l_specs: ARRAYED_LIST [TUPLE [name: STRING_8; type_code: INTEGER_32; is_asc: BOOLEAN]]
		do
			create l_specs.make (20)
			across
				db_fields (a_object) as al_fld_specs
			loop
				l_specs.force ([al_fld_specs.item.field_name, al_fld_specs.item.type_code, al_fld_specs.item.is_desc])
			end
			Result := l_specs.to_array
		end

	db_fields (a_object: attached like base_type): attached like fields_specifications_anchor
			-- Database fields list of TUPLE [field_name, is_desc, type_code, field_object].
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.db)
		end

	pk_fields (a_object: attached like base_type): attached like fields_specifications_anchor
			-- Primary key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.pk)
		ensure
			just_one: (0 |..| 1).has (Result.count)
		end

	ck_fields (a_object: attached like base_type): attached like fields_specifications_anchor
			-- Candidate key fields.
		do
			Result := fields_list (a_object, {SLE_CONSTANTS}.ck)
		end

	fields_list (a_object: attached like base_type; a_extension: STRING): attached like fields_specifications_anchor
		local
			i: INTEGER
			l_field_name: STRING
			l_field_object: ANY
			l_parts: LIST [STRING]
			l_type_code: INTEGER
		do
			i := reflector.field_count (a_object)
			check has_fields: i > 0 end
			create Result.make (i)
			across
				(1 |..| i) as ic
			loop
				l_field_name := reflector.field_name (ic.item, a_object)
				l_parts := l_field_name.split ('_')
				l_field_object := reflector.field (ic.item, a_object)

				if attached {INTEGER_32} l_field_object or attached {INTEGER_64} l_field_object then
					l_type_code := {SLE_CONSTANTS}.integer_type_code
				elseif attached {REAL_32} l_field_object or attached {REAL_64} l_field_object then
					l_type_code := {SLE_CONSTANTS}.real_type_code
				elseif attached {STRING_8} l_field_object or attached {STRING_32} l_field_object then
					l_type_code := {SLE_CONSTANTS}.text_type_code
				elseif attached {BOOLEAN} l_field_object then
					l_type_code := {SLE_CONSTANTS}.boolean_type_code
				elseif attached {DATE} l_field_object or attached {TIME} l_field_object or attached {DATE_TIME} l_field_object then
					l_type_code := {SLE_CONSTANTS}.date_type_code
				end

				if across l_parts as ic_parts some ic_parts.item.same_string (a_extension) end then
					if l_field_name.same_string ({SLE_CONSTANTS}.created_on_db_field_name) then
						Result.force ([l_field_name, False, {SLE_CONSTANTS}.date_type_code, a_object.created_on_db])
					elseif l_field_name.same_string ({SLE_CONSTANTS}.modified_on_db_field_name) then
						Result.force ([l_field_name, False, {SLE_CONSTANTS}.date_type_code, a_object.modified_on_db])
					elseif attached reflector.field (ic.item, a_object) as al_field_object then
						Result.force ([l_field_name, not across l_parts as ic_asc_parts some ic_asc_parts.item.same_string ("desc") end, l_type_code, al_field_object])
					end
				end
			end
		end

feature {NONE} --

	fields_specifications_anchor: detachable ARRAYED_LIST [TUPLE [field_name: STRING; is_desc: BOOLEAN; type_code: INTEGER; field_object: ANY]]

end
