note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SLE_READ_TEST_SET

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

	select_tests
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		local
			l_item: SLE_READ
			l_sql: STRING
			a_src_tables: ARRAY [TUPLE [STRING_8, detachable STRING_8, detachable STRING_8]]
		do
			create l_item
				-- Basic SQL SELECT ALL with JOIN between two tables
			a_src_tables := <<
							["my_src_table1", Void, Void],
							["my_src_table2", "my_src_table1", "id1 = pk1"]
							>>
			l_sql := l_item.generate_select_all_sql ("my_table", False, a_src_tables)
			assert_strings_equal ("simple_sql_with_join", " SELECT  ALL   FROM my_src_table1 my_src_table2 JOIN my_src_table1 ON id1 = pk1 ", l_sql)

				-- Basic SQL SELECT DISTINCT ALL with JOIN between two tables
			a_src_tables := <<
							["my_src_table1", Void, Void],
							["my_src_table2", "my_src_table1", "id1 = pk1"]
							>>
			l_sql := l_item.generate_select_all_sql ("my_table", True, a_src_tables)
			assert_strings_equal ("simple_sql_with_join", " SELECT  DISTINCT  ALL   FROM my_src_table1 my_src_table2 JOIN my_src_table1 ON id1 = pk1 ", l_sql)
		end

end


