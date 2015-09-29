require 'securerandom'

class Book
	attr_accessor :id, :description, :author, :edition, :quantity;

	def initialize(description:, author:, edition:, quantity:)
		@id = SecureRandom.uuid
		@description = description
		@author = author
		@edition = edition
		@quantity = quantity
	end

	def to_resource
		{
			id: @id,
			description: @description,
			author: @author,
			edition: @edition,
			quantity: @quantity
		}
	end

	def self.from_resource(resource_book)
		resource_book.keys.each do |field|
		  resource_book[field.to_sym] = resource_book.delete(field)
		end

		Book.new(resource_book)
	end
end