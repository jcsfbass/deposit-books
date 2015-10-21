require 'securerandom'

describe BookRepository do
	describe '.all' do
		subject(:books) { BookRepository.all }

		it 'should return a array with books' do
			books.each { |book| expect(book).to be_an_instance_of(Book) }
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

		  it 'should increase book quantity' do
		  	old_size = BookRepository.all.size
		  	new_book
		  	new_size = BookRepository.all.size
		    expect(new_size).to eq(old_size.next)
		  end

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

    it 'should decrease book quantity' do
    	old_size = BookRepository.all.size
    	deleted
    	new_size = BookRepository.all.size
      expect(new_size).to equal(old_size.pred)
    end

    it 'book is not saved' do
    	deleted
      expect(BookRepository.find(id)).to be_nil
    end
	end
end