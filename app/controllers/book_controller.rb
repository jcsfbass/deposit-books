require_relative '../helpers/body'
require_relative '../helpers/filter'
require_relative '../repositories/book_repository'

get '/livros' do
	filters = Filter.new.filter(params)
	return halt 400, {errors: filters[:errors]} unless filters[:errors].empty?

	BookRepository.all(filters[:values]).map { |book| book.to_resource }
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
	BookRepository.delete(id)
	halt 204
end