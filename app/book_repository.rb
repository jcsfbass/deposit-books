class BookRepository
	@books = [
		Book.new(id: 1, description: 'descrição 1', author: 'autor 1', edition: 1, quantity: 5),
		Book.new(id: 2, description: 'descrição 2', author: 'autor 2', edition: 2, quantity: 6)
	]

	def self.all
		@books
	end

	def self.find(id)
		@books.find { |book| book.id.to_s === id }
	end

	def self.new(resource_book)
		book = Book.from_resource(resource_book)
		book.id = @books.last.id.next
		@books.push book

		book
	end

	def self.delete(id)
		book = self.find(id)

		unless book.nil?
			@books.delete book
			return true
		end

		false
	end
end