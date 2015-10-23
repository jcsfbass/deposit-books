require_relative '../models/book'

class BookRepository
	@books = []
	for i in (1..20)
		@books.push(Book.new(description: "descrição #{i}", author: "autor #{i}", edition: i, quantity: i))
	end

	def self.all
		@books
	end

	def self.find(id)
		@books.find { |book| book.id === id }
	end

	def self.new(resource_book)
		@books.push Book.new(resource_book)
		@books.last
	end

	def self.update(id, partialUpdate)
		book = self.find(id)

		unless book.nil?
			book.update(partialUpdate)
			return book
		end
	end

	def self.delete(id)
		@books.delete(self.find(id))
	end
end