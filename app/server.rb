require 'sinatra'
require 'json'

before do
	content_type :json

	@books = [
		{
			id: 1,
			description: 'description 1',
			author: 'author 1',
			edition: 'edition 1',
			quantity: 5
		},
		{
			id: 2,
			description: 'description 2',
			author: 'author 2',
			edition: 'edition 2',
			quantity: 6
		}
	]
end

get '/livros' do
	{books: @books}.to_json
end

get '/livros/:id' do |id|
	@books.each do |book|
		return book.to_json if book[:id].to_s === id
	end
	halt 404
end

post '/livros' do
	halt 201, @books.first.to_json
end

delete '/livros/:id' do |id|
	@books.first.to_json
end