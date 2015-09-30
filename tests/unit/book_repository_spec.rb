describe BookRepository do
	describe '.all' do
		subject(:books) { BookRepository.all }

		it 'should return a array with books' do
			books.each { |book| expect(book).to be_an_instance_of(Book) }
		end
	end
end