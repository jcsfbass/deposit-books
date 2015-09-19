class BookRepository
	@books = [
		{
			id: 1,
			description: 'descrição 1',
			author: 'autor 1',
			edition: 'edição 1',
			quantity: 5
		},
		{
			id: 2,
			description: 'descrição 2',
			author: 'autor 2',
			edition: 'edição 2',
			quantity: 6
		}
	]

	def self.all
		@books
	end

	def self.find(id)
		@books.each { |book| return book if book[:id].to_s === id }
	end
end