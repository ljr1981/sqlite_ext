note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SLE_UPDATE_TEST_SET

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

	update_tests
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		local
			l_item: SLE_UPDATE
			l_sql: STRING
			l_fields:  ARRAY [TUPLE [col_name, col_expression: STRING]]
		do
			create l_item
			l_fields := <<
						["col1", "expr1"],
						["col2", "expr2"],
						["col3", "expr3"]
						>>
			l_sql := l_item.generate_update_sql ("my_table", l_fields, "True")
			assert_strings_equal ("update", " UPDATE my_table col1=expr1,col2=expr2,col3=expr3  WHERE True;", l_sql)
		end

end


