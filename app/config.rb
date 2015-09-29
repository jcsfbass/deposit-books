before { content_type :json }

after { body response.body.to_json }

configure { set :show_exceptions, false }

error { halt 500, {message: 'INTERNAL SERVER ERROR'} }

error Sinatra::NotFound do
	halt 404, {message: 'NOT FOUND'}
end