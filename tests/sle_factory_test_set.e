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
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		local
			l_item: SLE_FACTORY
			l_fields: ARRAY [TUPLE [STRING_8, INTEGER_32, BOOLEAN]]
		do
			create l_item
			l_fields := <<["my_integer", 1, {SLE_CONSTANTS}.is_asc],
							["my_text", 2, {SLE_CONSTANTS}.is_asc],
							["my_boolean", 3, {SLE_CONSTANTS}.is_asc],
							["my_date", 4, {SLE_CONSTANTS}.is_asc]>>
			assert_strings_equal ("new_table", new_table_string, l_item.generate_new_table_sql ("my_new_table", "new_id", l_fields))
		end

feature {NONE} -- Support

	new_table_string: STRING = " CREATE TABLE  IF NOT EXISTS my_new_table (new_id PRIMARY KEY  ASC  AUTOINCREMENT , my_integer INTEGER  ASC ,my_text TEXT  ASC ,my_boolean INTEGER  ASC ,my_date TEXT  ASC );"

end


