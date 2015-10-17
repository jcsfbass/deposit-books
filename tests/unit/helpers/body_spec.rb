require 'json'

describe Body do
  subject(:body) { Body.new(body_string) }

  describe '#to_hash' do
  	subject(:body_hash) { body.to_hash }

	  context 'when body is valid json' do
	    let(:body_string) { '{"field":"value","second_field":1}' }

	    it 'should convert string to hash with symbol keys' do
	    	expect(body_hash[:field]).to eq('value')
	    	expect(body_hash[:second_field]).to eq(1)
	    end
	  end

	  context 'when body is invalid json' do
	    let(:body_string) { '{"field":"value,"second_field":1}' }

	    it 'should raise JSON::ParserError' do
	      expect{ body_hash }.to raise_error(JSON::ParserError)
	    end
	  end
  end
end