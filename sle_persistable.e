deferred class
	SLE_PERSISTABLE

feature -- Access

	created_on_db: DATE_TIME attribute create Result.make_now end

	modified_on_db: DATE_TIME attribute create Result.make_now end

	template: detachable SLE_OBJECT_TEMPLATE
		deferred
		end

end
