require 'sinatra'
require 'json'

before do
	content_type :json
end

get '/'  do
	{
		array: [
			object: {
				string: '',
				integer: 1,
				boolen: true
			}
		]
	}.to_json
end

get '/403'  do
	halt 403, {
		message: 'Example for 403 http status'
	}.to_json
end