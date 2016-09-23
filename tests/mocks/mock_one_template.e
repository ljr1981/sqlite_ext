class
	MOCK_ONE_TEMPLATE

inherit
	SLE_OBJECT_TEMPLATE

feature -- Access

	pk: STRING = "mock_pk"

	fields: ARRAYED_LIST [STRING]
		once
			create Result.make_from_array (<<
				"text_field_dbe",
				"integer_field_dbe",
				"boolean_field_dbe",
				"date_field_dbe"
				>>)
		end

	base_type: detachable MOCK_ONE

end
