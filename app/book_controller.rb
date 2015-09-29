require_relative 'body'
require_relative 'book_repository'

get '/livros' do
	books = BookRepository.all.map { |book| book.to_resource }

	{books: books}
end

get '/livros/:id' do |id|
	book = BookRepository.find(id)

	return book.to_resource unless book.nil?
	halt 404, {message: 'Book not found'}
end

post '/livros' do
	halt 201, BookRepository.new(Body.new(request.body.string).to_hash).to_resource
end

patch '/livros/:id' do |id|
	book = BookRepository.update(id, Body.new(request.body.string).to_hash)

	return halt 200, book.to_resource unless book.nil?
	halt 404, {message: 'Book not found'}
end

delete '/livros/:id' do |id|
	return halt 204 if BookRepository.delete(id)
	halt 404, {message: 'Book not found'}
end