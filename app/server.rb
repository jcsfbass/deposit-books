require 'sinatra'
require 'json'

get '/'  do
	content_type :json
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