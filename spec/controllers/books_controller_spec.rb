require 'spec_helper'

describe BooksController do
	before :each do
		@fake_book = mock('Book', :id => '1')
		@posting1 = mock('Posting')
		@posting2 = mock('Posting')
		@postings = [@posting1, @posting2]
	end
	describe 'display_new' do
	end
	describe 'create_new' do
	end
	describe 'show_postings' do
		it 'should call the find method in the Book model to find the book refered to by the id param' do
			Book.should_receive(:find).with(@fake_book.id).and_return(@fake_book)
			get :show_postings, {:id => @fake_book.id}
		end
		it "should make the list of this book's non-expired postings available to the view" do
			Book.stub(:find).and_return(@fake_book)
			@fake_book.should_receive(:postings).and_return(@postings)
			
		end
		it 'should render the show_postings view' do
		end
	end
end
