deferred class
	SLE_CRUD

inherit
	LE_LOGGING_AWARE

feature -- Settings

	is_insert_only: BOOLEAN

	is_update_only: BOOLEAN

	is_select_only: BOOLEAN

	is_replace_only: BOOLEAN

	is_insert_or_replace: BOOLEAN

	is_insert_or_rollback: BOOLEAN

	is_insert_or_abort: BOOLEAN

	is_insert_or_fail: BOOLEAN

	is_insert_or_ignore: BOOLEAN

feature -- Setters

	reset_all
		do
			is_insert_only := False
			is_update_only := False
			is_select_only := False
			is_replace_only := False
			is_insert_or_replace := False
			is_insert_or_rollback := False
			is_insert_or_abort := False
			is_insert_or_fail := False
			is_insert_or_ignore := False
		end

	set_is_insert_only (a_is_insert_only: like is_insert_only)
			-- Sets `is_insert_only' with `a_is_insert_only'.
		do
			reset_all
			is_insert_only := a_is_insert_only
		ensure
			is_insert_only_set: is_insert_only = a_is_insert_only
		end

	set_is_update_only (a_is_update_only: like is_update_only)
			-- Sets `set_is_update_only' with `a_is_update_only'.
		do
			reset_all
			is_update_only := a_is_update_only
		ensure
			is_update_only_set: is_update_only = a_is_update_only
		end

	set_is_select_only (a_is_select_only: like is_select_only)
			-- Sets `set_is_select_only' with `a_is_select_only'.
		do
			reset_all
			is_select_only := a_is_select_only
		ensure
			is_select_only_set: is_select_only = a_is_select_only
		end

	set_is_replace_only (a_is_replace_only: like is_replace_only)
			-- Sets `is_replace_only' with `a_is_replace_only'.
		do
			reset_all
			is_replace_only := a_is_replace_only
		ensure
			is_replace_only_set: is_replace_only = a_is_replace_only
		end

	set_is_insert_or_replace (a_is_insert_or_replace: like is_insert_or_replace)
			-- Sets `is_insert_or_replace' with `a_is_insert_or_replace'.
		do
			reset_all
			is_insert_or_replace := a_is_insert_or_replace
		ensure
			is_insert_or_replace_set: is_insert_or_replace = a_is_insert_or_replace
		end

	set_is_insert_or_rollback (a_is_insert_or_rollback: like is_insert_or_rollback)
			-- Sets `is_insert_or_rollback' with `a_is_insert_or_rollback'.
		do
			reset_all
			is_insert_or_rollback := a_is_insert_or_rollback
		ensure
			is_insert_or_rollback_set: is_insert_or_rollback = a_is_insert_or_rollback
		end

	set_is_insert_or_abort (a_is_insert_or_abort: like is_insert_or_abort)
			-- Sets `is_insert_or_abort' with `a_is_insert_or_abort'.
		do
			reset_all
			is_insert_or_abort := a_is_insert_or_abort
		ensure
			is_insert_or_abort_set: is_insert_or_abort = a_is_insert_or_abort
		end

	set_is_insert_or_fail (a_is_insert_or_fail: like is_insert_or_fail)
			-- Sets `is_insert_or_fail' with `a_is_insert_or_fail'.
		do
			reset_all
			is_insert_or_fail := a_is_insert_or_fail
		ensure
			is_insert_or_fail_set: is_insert_or_fail = a_is_insert_or_fail
		end

	set_is_insert_or_ignore (a_is_insert_or_ignore: like is_insert_or_ignore)
			-- Sets `is_insert_or_ignore' with `a_is_insert_or_ignore'.
		do
			reset_all
			is_insert_or_ignore := a_is_insert_or_ignore
		ensure
			is_insert_or_ignore_set: is_insert_or_ignore = a_is_insert_or_ignore
		end

end
