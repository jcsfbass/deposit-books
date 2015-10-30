class Filter
	VALIDATORS = {
		limit: {
			validation: lambda { |limit| !limit or limit < 1 or limit > 100 },
			error_message: 'Limit should be a positive number, not null and less than 100'
		},
		offset: {
			validation: lambda { |offset| !offset or offset < 0 },
			error_message: 'Offset should be a positive number'
		}
	}

	def initialize
		@filters = {values: {}, errors: []}
	end

	def filter(params={})
		params.each { |param_name, param| filter_param(param_name, param) }

		@filters
	end

	private

	def filter_param(param_name_as_string, param_as_string)
		param = Integer(param_as_string) rescue false
		param_name = param_name_as_string.to_sym

		unless VALIDATORS.has_key? param_name then @filters[:errors] << {message: "Parameter #{param_name} is invalid."}
		else
			param_validator = VALIDATORS[param_name]
			if param_validator[:validation].call param then @filters[:errors] << {message: param_validator[:error_message]}
			else @filters[:values][param_name] = param
			end
		end
	end
end

# TODO:
# Errors deve ser uma coleção de objetos
# Validators deve ser uma coleção de objetos