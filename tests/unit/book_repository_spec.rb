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
		  let(:id) { BookRepository.all.first.id }

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
end