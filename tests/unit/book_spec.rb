require 'uuid'

describe Book do
  describe '.new' do
    subject(:book) { Book.new(attributes) }

    context 'when run with all attributes' do
      let(:attributes) { {description: 'd', author: 'a', edition: 1, quantity: 1} }

      it 'should set book attributes correctly' do
        expect(book.description).to eq(attributes[:description])
        expect(book.author).to eq(attributes[:author])
        expect(book.edition).to eq(attributes[:edition])
        expect(book.quantity).to eq(attributes[:quantity])
      end

      it 'should set id with valid uuid' do
        expect(UUID.validate book.id).to be_truthy
      end
    end

    context 'when run with missing attributes' do
      let(:attributes) { {description: 'd', author: 'a', quantity: 1} }

      it 'should raise ArgumentError' do
        expect{ book }.to raise_error(ArgumentError)
      end
    end
  end
end
