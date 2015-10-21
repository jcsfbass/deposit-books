require 'uuid'
require 'securerandom'
require 'rack/test'

describe 'Books' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

  before { get '/livros' }
  let(:books) { JSON.parse(last_response.body) }

  describe 'GET /livros' do
    it 'should return status 200' do
      expect(last_response).to be_ok
    end

    it 'should return an array of books' do
      books.each { |book| expect(book).to be_book }
    end
  end

  describe 'GET /livros/:id' do
  	before { get "/livros/#{id}" }
  	let(:response) { JSON.parse(last_response.body) }

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

	    it 'should return a error message' do
  	    expect(response['message']).to eq('Book not found')
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