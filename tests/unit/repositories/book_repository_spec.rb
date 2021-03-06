require 'uuid'
require 'securerandom'

describe BookRepository do
	describe '.all' do
		subject(:books) { BookRepository.all(offset: offset, limit: limit) }
		let(:limit) { 20 }
		let(:offset) { 0 }

		context 'when get with limit' do
			let(:limit) { 10 }

			it 'quantity of books should be equal to limit' do
				expect(books.size).to eq(limit)
			end

			it 'should return a array with books' do
				books.each { |book| expect(book).to be_a Book }
			end
		end

		context 'when get without limit' do
			subject(:books) { BookRepository.all }

			it 'quantity of books should be equal to 20' do
				expect(books.size).to eq(20)
			end

			it 'should return a array with books' do
				books.each { |book| expect(book).to be_a Book }
			end
		end

		context 'when get with offset' do
			let(:offset) { 20 }

			it 'should start from offset' do
				expect(books.first.description).to match(/#{offset}$/)
			end
		end

		context 'when get without offset' do
			subject(:books) { BookRepository.all }

			it 'should start from zero' do
				expect(books.first.description).to match(/0$/)
			end
		end

		context 'when offset is greater than the quantity of books' do
			let(:offset) { 200 }
			it 'should return an empty array' do
				expect(books).to be_empty
			end
		end

		context 'when limit is greater than the necessary' do
			let(:offset) { 190 }
			let(:limit) { 50 }
			it 'should return the remaining quantity' do
				expect(books.size).to eq(10)
			end
		end
	end

	describe '.find' do
		subject(:book) { BookRepository.find(id) }

		context 'when find existent book' do
		  let(:id) { BookRepository.all.sample.id }

		  it 'should return a book correctly' do
		    expect(book.id).to eq(id)
		  end
		end

		context 'when find nonexistent book' do
		  let(:id) { SecureRandom.uuid }

		  it 'should return nil' do
		    expect(book).to be_nil
		  end
		end
	end

	describe '.new' do
		subject(:new_book) { BookRepository.new(attributes) }

		context 'when resource is correct' do
		  let(:attributes) { {description: 'd', author: 'a', edition: 1, quantity: 1} }

		  it 'should return a new book' do
		    expect(UUID.validate new_book.id).to be_truthy
		    expect(new_book.description).to eq(attributes[:description])
		    expect(new_book.author).to eq(attributes[:author])
		    expect(new_book.edition).to eq(attributes[:edition])
		    expect(new_book.quantity).to eq(attributes[:quantity])
		  end

		  it 'should save the book' do
		    expect(BookRepository.find(new_book.id)).to eq(new_book)
		  end
		end

		context 'when resource is not correct' do
		  let(:attributes) { {description: 'd', author: 'a', quantity: 1} }

		  it 'should raise ArgumentError' do
		    expect{ new_book }.to raise_error(ArgumentError)
		  end
		end
	end

	describe '.update' do
	  subject(:updated_book) { BookRepository.update(id, partialUpdate) }

	  context 'when update existent book' do
	    let(:id) { BookRepository.all.sample.id }

	    context 'and partialUpdate is correct' do
	      let(:partialUpdate) { {description: 'de', edition: 2} }

	      it 'should update correctly' do
	        expect(updated_book.description).to eq(partialUpdate[:description])
	        expect(updated_book.edition).to eq(partialUpdate[:edition])

	        book = BookRepository.find(updated_book.id)

	        expect(book.description).to eq(partialUpdate[:description])
	        expect(book.edition).to eq(partialUpdate[:edition])
	      end
	    end

	    context 'and partialUpdate is not correct' do
	      let(:partialUpdate) { {incorrect: 'i'} }

	      it 'should raise ArgumentError' do
	        expect{ updated_book }.to raise_error(ArgumentError)
	      end
	    end
	  end

	  context 'when update nonexistent book' do
	    let(:id) { SecureRandom.uuid }
	    let(:partialUpdate) { {description: 'de', edition: 2} }

	    it 'should return nil' do
	      expect(updated_book).to be_nil
	    end
	  end
	end

	describe '.delete' do
	  subject(:deleted) { BookRepository.delete(id) }
    let(:id) { BookRepository.all.sample.id }

    it 'book is not saved' do
    	deleted
      expect(BookRepository.find(id)).to be_nil
    end
	end
end