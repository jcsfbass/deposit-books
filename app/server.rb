require 'sinatra'
require 'json'

require_relative 'book_repository'

before do
	content_type :json
end

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
	BookRepository.all.first.to_json
end