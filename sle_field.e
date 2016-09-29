note
	description: "[
		A notion of a "field" that participates in an {SLE_OBJECT_TEMPLATE} using CRUD
		]"

deferred class
	SLE_FIELD

inherit
	SLE_CONSTANTS

feature -- Access

	key: STRING
		deferred
		end

	value: detachable ANY

	db_value: detachable STRING
		deferred
		end

	type_code: INTEGER

feature -- Converters

	db_to_value
		deferred
		end

	value_to_db
		deferred
		end

feature -- Setters

	set_value (a_value: like value)
			-- `set_value' with `a_value'
		do
			value := a_value
		ensure
			set: value ~ a_value
		end

invariant
	valid_key: across key as ic all (('a').code |..| ('z').code).has (ic.item.code) or ic.item = '_' end
	valid_type_code: type_codes.has (type_code)

end
