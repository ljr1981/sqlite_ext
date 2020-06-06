note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SLE_FACTORY_TEST_SET

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

	factory_tests
			-- create a new table SQL using SLE_FACTORY
		local
			l_item: SLE_FACTORY
		do
			create l_item
			l_item.set_table_name ("my_new_table")
			l_item.set_pk_name ("new_id")
			l_item.add_integer_field ("my_integer")
			l_item.add_text_field ("my_text")
			l_item.add_boolean_field ("my_boolean")
			l_item.add_date_field ("my_date")
			assert_strings_equal ("new_table", new_table_string, l_item.new_table_sql)
		end

feature {NONE} -- Support

	new_table_string: STRING = " CREATE TABLE  IF NOT EXISTS my_new_table (new_id INTEGER  PRIMARY KEY  ASC  AUTOINCREMENT , my_integer INTEGER  ASC ,my_text TEXT  ASC ,my_boolean INTEGER  ASC ,my_date TEXT  ASC );"

end


