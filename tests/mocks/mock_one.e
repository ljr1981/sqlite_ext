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
			integer_field_db_asc := 1_001
			boolean_field_db_asc := True
		end

feature -- Access

	text_field_db_asc: STRING attribute Result := "text_field_data" end

	integer_field_db_asc: INTEGER

	boolean_field_db_asc: BOOLEAN

	date_field_db_asc: DATE_TIME attribute create Result.make_from_string_default ("01/01/2016 00:00:00.000 AM") end
			-- "[0]mm/[0]dd/yyyy hh12:[0]mi:[0]ss.ff3 AM"

feature -- Supporting

	mock_pk: INTEGER_64

	template: detachable MOCK_ONE_TEMPLATE

	base_type: detachable MOCK_ONE

end
