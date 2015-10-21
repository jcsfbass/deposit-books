require 'uuid'
require 'rack/test'

describe 'Books' do
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

  let(:body) { JSON.parse(last_response.body) }

  describe 'GET /livros' do
  	before(:all) { get '/livros' }

    it 'should return status 200' do
      expect(last_response).to be_ok
    end

    it 'should return an array of books' do
      body.each do |element|
      	expect(element).to be_book
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