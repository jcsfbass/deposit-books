require 'sinatra'
require 'json'

require_relative 'book_repository'

before { content_type :json }

not_found { halt 404, {}.to_json }

get '/livros' do
	{books: BookRepository.all}.to_json
end

get '/livros/:id' do |id|
	book = BookRepository.find(id)

	return book.to_json unless book.nil?
	halt 404
end

post '/livros' do
	halt 201, BookRepository.all.first.to_json
end

delete '/livros/:id' do |id|
		return halt 204 if BookRepository.delete(id)
		halt 404
end