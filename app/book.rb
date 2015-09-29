require 'securerandom'

class Book
	attr_accessor :id, :description, :author, :edition, :quantity

	def initialize(description:, author:, edition:, quantity:)
		@id = SecureRandom.uuid
		@description = description
		@author = author
		@edition = edition
		@quantity = quantity
	end

	def update(description: nil, author: nil, edition: nil, quantity: nil)
		@description = description unless description.nil?
		@author = author unless author.nil?
		@edition = edition unless edition.nil?
		@quantity = quantity unless quantity.nil?
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
		self.new(resource_book)
	end
end