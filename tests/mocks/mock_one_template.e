class
	MOCK_ONE_TEMPLATE

inherit
	SLE_OBJECT_TEMPLATE

feature -- Access

	table_name: STRING = "mock_one"

	pk: STRING = "mock_pk"

	fields: HASH_TABLE [TUPLE [type_code: INTEGER], STRING]
		once
			create Result.make (4)
			Result.force ([{SLE_CONSTANTS}.text_type_code], "text_field_db_asc")
			Result.force ([{SLE_CONSTANTS}.integer_type_code], "integer_field_db_asc")
			Result.force ([{SLE_CONSTANTS}.boolean_type_code], "boolean_field_db_asc")
			Result.force ([{SLE_CONSTANTS}.date_type_code], "date_field_db_asc")
		end

	base_type: detachable MOCK_ONE

end
