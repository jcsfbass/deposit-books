require 'uuid'

describe Book do
  subject(:book) { Book.new({description: 'd', author: 'a', edition: 1, quantity: 1}) }

  describe '.new' do
    subject(:new_book) { Book.new(attributes) }

    context 'when run with all attributes' do
      let(:attributes) { {description: 'd', author: 'a', edition: 1, quantity: 1} }

      it 'should set book attributes correctly' do
        expect(new_book.description).to eq(attributes[:description])
        expect(new_book.author).to eq(attributes[:author])
        expect(new_book.edition).to eq(attributes[:edition])
        expect(new_book.quantity).to eq(attributes[:quantity])
      end

      it 'should set id with valid uuid' do
        expect(UUID.validate new_book.id).to be_truthy
      end
    end

    context 'when run with missing attributes' do
      let(:attributes) { {description: 'd', author: 'a', quantity: 1} }

      it 'should raise ArgumentError' do
        expect{ new_book }.to raise_error(ArgumentError)
      end
    end

    context 'when run with nonexistent attributes' do
      let(:attributes) { {description: 'd', author: 'a', edition: 1, nonexistent: 'ne', quantity: 1} }

      it 'should raise ArgumentError' do
        expect{ new_book }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#update' do
    subject(:updated_book) do
      book.update(attributes)
      book
    end

    context 'when run with all attributes' do
      let(:attributes) { {description: 'dd', author: 'aa', edition: 2, quantity: 2} }

      it 'should update all attributes' do
        expect(updated_book.description).to eq(attributes[:description])
        expect(updated_book.author).to eq(attributes[:author])
        expect(updated_book.edition).to eq(attributes[:edition])
        expect(updated_book.quantity).to eq(attributes[:quantity])
      end
    end

    context 'when run with missing attributes' do
      let(:attributes) { {description: 'dd', author: 'aa', quantity: 2} }

      it 'should update only sent attributes' do
        expect(updated_book.description).to eq(attributes[:description])
        expect(updated_book.author).to eq(attributes[:author])
        expect(updated_book.edition).to eq(1)
        expect(updated_book.quantity).to eq(attributes[:quantity])
      end
    end

    context 'when run with nonexistent attributes' do
      let(:attributes) { {description: 'd', author: 'a', edition: 1, nonexistent: 'ne', quantity: 1} }

      it 'should raise ArgumentError' do
        expect{ updated_book }.to raise_error(ArgumentError)
      end
    end
  end
end
