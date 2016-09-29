note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MOCK_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	mock_tests
			-- New test routine
		local
			l_item: MOCK_ONE
			l_template: MOCK_ONE_TEMPLATE
			l_fields: ARRAYED_LIST [TUPLE [field_name: STRING_8; field_object: ANY]]
			l_factory: SLE_FACTORY
			l_sql: STRING
		do
			create l_item
			assert_strings_equal ("text_field_dbe", "text_field_data", l_item.text_field_db_asc)
			assert_integers_equal ("integer_field_dbe", 1_001, l_item.integer_field_db_asc)
			assert_booleans_equal ("boolean_field_dbe", True, l_item.boolean_field_db_asc)
			assert_strings_equal ("date_field_dbe", "01/01/2016 12:00:00.000 AM", l_item.date_field_db_asc.out)

			create l_template
			l_fields := l_template.db_fields (l_item)
			assert_integers_equal ("db_count", 6, l_fields.count)
			l_fields := l_template.pk_fields (l_item)
			assert_integers_equal ("pk_count", 1, l_fields.count)
			l_fields := l_template.ck_fields (l_item)
			assert_integers_equal ("ck_count", 0, l_fields.count)

			create l_factory
			l_sql := l_factory.generate_new_table_from_template_sql (l_item, l_template)
			assert_strings_equal ("mock_creation_sql", " CREATE TABLE  IF NOT EXISTS mock_one (mock_pk PRIMARY KEY  ASC , text_field_db_asc TEXT  ASC ,date_field_db_asc TEXT  ASC ,boolean_field_db_asc INTEGER  ASC ,integer_field_db_asc INTEGER  ASC );", l_sql)
		end

end


