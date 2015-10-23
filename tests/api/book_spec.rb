require 'uuid'
require 'securerandom'
require 'rack/test'

describe 'Books' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

  before { get '/livros' }
  subject(:books) { JSON.parse(last_response.body) }

  describe 'GET /livros' do
    it 'should return status 200' do
      expect(last_response).to be_ok
    end

    it 'should return an array of books' do
      books.each { |element| expect(element).to be_book }
    end

    context 'when limit is used' do
      before { get '/livros', limit: limit }
      subject(:response) { JSON.parse(last_response.body) }

      context 'and limit is valid' do
        let(:limit) { 10 }

        it 'should return the quantity of books equal to limit' do
          response.each { |element| expect(element).to be_book }
          expect(response.size).to eq(limit)
        end
      end

      context 'and limit is greather than the quantity of books' do
        let(:limit) { books.size.next }

        it 'should return the quantity of existents books' do
          response.each { |element| expect(element).to be_book }
          expect(response.size).to eq(books.size)
        end
      end

      context 'and limit is zero or less than zero' do
        let(:limit) { -1 }

        it 'should return status 400' do
          expect(last_response).to be_bad_request
        end

        it 'should return an error message' do
          expect(response['message']).to eq('Limit should be greather than zero')
        end
      end

      context 'and limit is not number' do
        let(:limit) { 'is not number' }

        it 'should return status 400' do
          expect(last_response).to be_bad_request
        end

        it 'should return an error message' do
          expect(response['message']).to eq('Limit should be greather than zero')
        end
      end
    end
  end

  describe 'GET /livros/:id' do
  	before { get "/livros/#{id}" }
  	subject(:response) { JSON.parse(last_response.body) }

  	context 'when find existent book' do
  		let(:id) { books.first['id'] }

  		it 'should return status 200' do
	      expect(last_response).to be_ok
	    end

  	  it 'should return a book' do
  	    expect(response).to be_book
  	  end
  	end

  	context 'when find nonexistent book' do
  	  let(:id) { SecureRandom.uuid }

  	  it 'should return status 404' do
	      expect(last_response).to be_not_found
	    end

	    it 'should return an error message' do
  	    expect(response['message']).to eq('Book not found')
  	  end
  	end
  end

  describe 'POST /livros' do
  	before { post '/livros', body.to_json, 'CONTENT-TYPE' => 'application/json' }
  	subject(:response) { JSON.parse(last_response.body) }

  	context 'when create book with valid body' do
  		let(:body) { {description: 'new description', author: 'new author', edition: 2, quantity: 10} }

  	  it 'should return status 201' do
	      expect(last_response).to be_created
	    end

	    it 'should return a created book' do
	      expect(response).to be_book
	      expect(response['description']).to eq(body[:description])
	      expect(response['author']).to eq(body[:author])
	      expect(response['edition']).to eq(body[:edition])
	      expect(response['quantity']).to eq(body[:quantity])
	    end
  	end

  	context 'when create book with invalid body' do
  	  let(:body) { {descriptio: 'new description', author: 'new author', quantity: 10} }

  	  it 'should return status 500' do
  	    expect(last_response).to be_server_error
  	  end

  	  it 'should return an error message' do
  	    expect(response['message']).to eq('INTERNAL SERVER ERROR')
  	  end
  	end
  end

  describe 'PATCH /livros/:id' do
    before { patch "/livros/#{id}", body.to_json, 'CONTENT-TYPE' => 'application/json' }
  	subject(:response) { JSON.parse(last_response.body) }

  	context 'when update existent book' do
  	  let(:id) { books.first['id'] }

  	  context 'with valid body' do
  	    let(:body) { {description: 'updated description', author: 'updated author'} }

  	    it 'should return status 200' do
  	      expect(last_response).to be_ok
  	    end

  	    it 'should return updated book' do
  	      expect(response).to be_book
  	      expect(response['description']).to eq(body[:description])
	      	expect(response['author']).to eq(body[:author])
  	    end
  	  end

  	  context 'with invalid body' do
  	    let(:body) { {descriptio: 'updated description', author: 'updated author'} }

	  	  it 'should return status 500' do
	  	    expect(last_response).to be_server_error
	  	  end

	  	  it 'should return an error message' do
	  	    expect(response['message']).to eq('INTERNAL SERVER ERROR')
	  	  end
  	  end
  	end

  	context 'when update nonexistent book' do
  	  let(:id) { SecureRandom.uuid }
  	  let(:body) { {description: 'updated description', author: 'updated author'} }

  	  it 'should return status 404' do
	      expect(last_response).to be_not_found
	    end

	    it 'should return an error message' do
  	    expect(response['message']).to eq('Book not found')
  	  end
  	end
  end

  describe 'DELETE /livros/:id' do
  	before { delete "/livros/#{id}" }
  	subject(:response) { JSON.parse(last_response.body) }

  	context 'when delete existent book' do
  		let(:id) { books.first['id'] }

  		it 'should return status 204' do
	      expect(last_response).to be_empty
	    end

	    it 'should not return when find it' do
	      get "/livros/#{id}"
	      expect(last_response).to be_not_found
	      expect(response['message']).to eq('Book not found')
	    end
  	end

  	context 'when delete nonexistent book' do
  	  let(:id) { SecureRandom.uuid }

  	  it 'should return status 204' do
	      expect(last_response).to be_empty
	    end
  	end
  end
end

class Hash
	def book?
		return true if
			self.size === 5 and
			UUID.validate self['id'] and
			self['description'].is_a? String and
			self['author'].is_a? String and
			self['edition'].is_a? Fixnum and
			self['quantity'].is_a? Fixnum

		false
	end
end