note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SLE_CREATE_TEST_SET

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

	create_tests
			-- New test routine
		local
			l_item: SLE_CREATE
			l_fields: ARRAY [TUPLE [col_name, col_value: STRING]]
			l_sql: STRING
		do
			create l_item
			l_fields := <<
						["col1", "val1"],
						["col2", "val2"],
						["col3", "val3"],
						["col4", "val4"]
						>>
			l_sql := l_item.generate_insert_sql ("my_table_name", l_fields)
			assert_strings_equal ("insert_sql", " INSERT  INTO my_table_name (col1,col2,col3,col4) VALUES (val1,val2,val3,val4);", l_sql)
		end

end


