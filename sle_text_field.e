deferred class
	SLE_TEXT_FIELD

inherit
	SLE_FIELD
		redefine
			value
		end

feature --

	value: detachable STRING

	attached_value: attached like value do check is_attached: attached value as al_value then Result := al_value end end

	db_value: detachable STRING

feature --

	db_to_value
		do
			value := db_value
		end

	value_to_db
		do
			db_value := value
		end
end
