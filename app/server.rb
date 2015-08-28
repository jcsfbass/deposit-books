require 'sinatra'
require 'json'

before do
	content_type :json

	@books = [
		{
			description: 'description 1',
			author: 'author 1',
			edition: 'edition 1'
		},
		{
			description: 'description 2',
			author: 'author 2',
			edition: 'edition 2'
		}
	]
end

get '/livros' do
	{books: @books}.to_json
end

get '/livros/:id' do |id|
	@books.first.to_json
end

post '/livros' do
	halt 201, @books.first.to_json
end

delete '/livros' do
	@books.first.to_json
end

delete '/livros/:id' do |id|
	@books.first.to_json
end