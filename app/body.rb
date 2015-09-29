require 'json'

class Body
	def initialize(body_string)
		@body_string = body_string
	end

	def to_hash
		body_hash = JSON.parse(@body_string)

		body_hash.keys.each do |field|
		  body_hash[field.to_sym] = body_hash.delete(field)
		end

		body_hash
	end
end