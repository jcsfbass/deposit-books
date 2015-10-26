require_relative '../helpers/body'
require_relative '../repositories/book_repository'

get '/livros' do
	if params['limit'].nil? and params['offset'].nil?
		BookRepository.all.map { |book| book.to_resource }
	elsif params['limit'].nil?
		offset = Integer(params['offset']) rescue -1

		return halt 400, {message: 'Offset should be greather than zero'} if offset < 0
		BookRepository.all(offset: offset).map { |book| book.to_resource }
	elsif params['offset'].nil?
		limit = params['limit'].to_i

		return halt 400, {message: 'Limit should be greather than zero'} if limit <= 0
		return halt 400, {message: 'Limit should be equal or less than 100'} if limit > 100
		BookRepository.all(limit: limit).map { |book| book.to_resource }
	else
		limit = params['limit'].to_i
		offset = params['offset'].to_i

		return halt 400, {message: 'Limit should be greather than zero'} if limit <= 0
		return halt 400, {message: 'Limit should be equal or less than 100'} if limit > 100
		return halt 400, {message: 'Offset should be greather than zero'} if offset < 0
		BookRepository.all(limit: limit, offset: offset).map { |book| book.to_resource }
	end
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