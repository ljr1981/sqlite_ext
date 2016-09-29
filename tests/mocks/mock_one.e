class
	MOCK_ONE

inherit
	SLE_PERSISTABLE
		redefine
			default_create
		end

feature {NONE} -- Initialziation

	default_create
			-- <Precursor>
		do
			mock_int_field_db_desc := 1_001
			mock_bool_field_db := True
		end

feature -- Access

	mock_text_field_db: STRING attribute Result := "text_field_data" end

	mock_int_field_db_desc: INTEGER

	mock_bool_field_db: BOOLEAN

	mock_date_field_db: DATE_TIME attribute create Result.make_from_string_default ("01/01/2016 00:00:00.000 AM") end
			-- "[0]mm/[0]dd/yyyy hh12:[0]mi:[0]ss.ff3 AM"

feature -- Supporting

	mock_pk: INTEGER_64

	table_name: STRING = "mock_one"

	template: detachable MOCK_ONE_TEMPLATE

	base_type: detachable MOCK_ONE

end
