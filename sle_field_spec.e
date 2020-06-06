note
	description: "Representation of a Field Specification"

class
	SLE_FIELD_SPEC

inherit
	SLE_ANY

create
	make,
	make_blob,
	make_boolean,
	make_date,
	make_integer,
	make_text

feature {NONE} -- Initialization

-- TUPLE [STRING_8, INTEGER_32, BOOLEAN]

	make (a_fld_name: STRING; a_type: like data_type; a_is_asc: like is_asc)
			--
		do
			field_name := a_fld_name
			data_type := a_type
			is_asc := a_is_asc
		end

	make_integer (a_fld_name: STRING)
		do
			make (a_fld_name, {SLE_CONSTANTS}.Integer_type_code, True)
		end
	make_text (a_fld_name: STRING)
		do
			make (a_fld_name, {SLE_CONSTANTS}.Text_type_code, True)
		end

	make_boolean (a_fld_name: STRING)
		do
			make (a_fld_name, {SLE_CONSTANTS}.Boolean_type_code, True)
		end

	make_date (a_fld_name: STRING)
		do
			make (a_fld_name, {SLE_CONSTANTS}.Date_type_code, True)
		end

	make_blob (a_fld_name: STRING)
		do
			make (a_fld_name, {SLE_CONSTANTS}.Blob_type_code, True)
		end

feature

	field_name: STRING

	data_type: INTEGER_32

	is_asc: BOOLEAN

feature -- Output

	spec: TUPLE [STRING_8, INTEGER_32, BOOLEAN]
		do
			Result := [field_name, data_type, is_asc]
		end

feature {NONE} -- Implementation: Constants Ref

	const: SLE_CONSTANTS
			--
		once
			create Result
		end

end
