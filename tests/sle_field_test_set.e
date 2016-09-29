note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SLE_FIELD_TEST_SET

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

	mock_text_field_tests
			-- New test routine
		note
			testing:  "execution/isolated", "execution/serial"
		local
			l_text_field: MOCK_TEXT_FIELD
		do
			create l_text_field
			l_text_field.set_value ("test")
			assert_strings_equal ("test", "test", l_text_field.attached_value)
		end

end


