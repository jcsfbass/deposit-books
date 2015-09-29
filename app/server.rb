require 'sinatra'
require 'json'
require_relative 'book'
require_relative 'book_repository'

before { content_type :json }

after { body response.body.to_json }

configure { set :show_exceptions, false }

error { halt 500, {message: 'INTERNAL SERVER ERROR'} }

error Sinatra::NotFound do
	halt 404, {message: 'NOT FOUND'}
end

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
	halt 201, BookRepository.new(JSON.parse(request.body.string)).to_resource
end

delete '/livros/:id' do |id|
	return halt 204 if BookRepository.delete(id)
	halt 404, {message: 'Book not found'}
end