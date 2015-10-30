describe Filter do
	subject(:filter) { Filter.new }

  describe '.filter' do
  	subject(:parameters) { filter.filter({'offset' => offset, 'limit' => limit}) }
  	let(:offset) { '0' }
  	let(:limit)  { '100' }

  	context 'when offset and limit is valid' do
  		it 'should return in values' do
  			expect(parameters[:values][:limit]).to eq(limit.to_i)
  			expect(parameters[:values][:offset]).to eq(offset.to_i)
  		end

  		it 'errors should be empty' do
  			expect(parameters[:errors]).to be_empty
  		end
  	end

  	context 'when offset is not number' do
  		let(:offset) { 'is not number' }

  		it 'values should not have offset' do
  			expect(parameters[:values][:offset]).to be_nil
  		end

  		it 'should return error message' do
  			expect(parameters[:errors].size).to eq(1)
  			expect(parameters[:errors]).to include({message: 'Offset should be a positive number'})
  		end
  	end

  	context 'when offset is less than zero' do
  		let(:offset) { -1 }

  		it 'values should not have offset' do
  			expect(parameters[:values][:offset]).to be_nil
  		end

  		it 'should return error message' do
  			expect(parameters[:errors].size).to eq(1)
  			expect(parameters[:errors]).to include({message: 'Offset should be a positive number'})
  		end
  	end

  	context 'when limit is not number' do
  		let(:limit) { 'is not number' }

  		it 'values should not have limit' do
  			expect(parameters[:values][:limit]).to be_nil
  		end

  		it 'should return error message' do
  			expect(parameters[:errors].size).to eq(1)
  			expect(parameters[:errors]).to include({message: 'Limit should be a positive number, not null and less than 100'})
  		end
  	end

  	context 'when limit less than one' do
  		let(:limit) { 0 }

  		it 'values should not have limit' do
  			expect(parameters[:values][:limit]).to be_nil
  		end

  		it 'should return error message' do
  			expect(parameters[:errors].size).to eq(1)
  			expect(parameters[:errors]).to include({message: 'Limit should be a positive number, not null and less than 100'})
  		end
  	end

  	context 'when limit is greater than 100' do
  		let(:limit) { 101 }

  		it 'values should not have limit' do
  			expect(parameters[:values][:limit]).to be_nil
  		end

  		it 'should return error message' do
  			expect(parameters[:errors].size).to eq(1)
  			expect(parameters[:errors]).to include({message: 'Limit should be a positive number, not null and less than 100'})
  		end
  	end

  	context 'when offset and limit are wrong' do
  		let(:offset) { -1 }
  		let(:limit) { 101 }

  		it 'values should be empty' do
  			expect(parameters[:values]).to be_empty
  		end

  		it 'should return error messages' do
  			expect(parameters[:errors].size).to eq(2)
  			expect(parameters[:errors]).to include({message: 'Offset should be a positive number'})
  			expect(parameters[:errors]).to include({message: 'Limit should be a positive number, not null and less than 100'})
  		end
  	end

  	context 'when filter empty params' do
  		subject(:parameters) { filter.filter }

  		it 'errors should be empty' do
  			expect(parameters[:errors]).to be_empty
  		end

  		it 'values should be empty' do
  			expect(parameters[:values]).to be_empty
  		end
  	end

  	context 'when filter nonexistent param' do
  		subject(:parameters) { filter.filter({'invalid' => invalid}) }
  		let(:invalid) { 'invalid' }

  		it 'should not have in values' do
  			expect(parameters[:values]).to be_empty
  		end

  		it 'should return error message' do
  			expect(parameters[:errors]).to include({message: "Parameter #{invalid} is invalid."})
  		end
  	end
  end
end