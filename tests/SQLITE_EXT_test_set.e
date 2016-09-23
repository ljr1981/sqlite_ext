note
	description: "Tests of {SQLITE_EXT}."
	testing: "type/manual"

class
	SQLITE_EXT_TEST_SET

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

	SQLITE_EXT_tests
			-- `SQLITE_EXT_tests'
		local
			l_any: SLE_ANY
			l_create: SLE_CREATE
			l_crud: SLE_CRUD
			l_delete: SLE_DELETE
			l_factory: SLE_FACTORY
			l_read: SLE_READ
			l_update: SLE_UPDATE
		do
			do_nothing -- yet ...
		end

end
