require 'spec_helper'

describe BooksController do
	before :each do
		@fake_course = mock('Course', :id => '1')
		@fake_book = mock('Book', :id => '1', :title => 'testbook1', :author => 'bob', :edition => '1', :isbn => '0000000000000')
		@posting1 = mock('Posting', :created_at => Time.now)
		@posting2 = mock('Posting', :created_at => Time.now - 3.days)
		@postings = [@posting1, @posting2]
		@non_expired_postings = [@posting1]
	end
	describe 'display_new' do
	end
	describe 'create_new' do
		it 'should check if the given course exists' do
			Course.should_receive(:find).with(@fake_course.id)
			Book.stub(:create)
			Book.stub(:find_by_isbn).and_return(@fake_book)
			Requirement.stub(:create)
			put :create_new_book, {:id => @fake_course.id, :title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}
		end
		it 'sucess path' do
			it 'should call the create method in the Book model' do
				Course.stub(:find).and_return(@fake_course)
				Book.should_receive(:create).with({:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn})
				Book.stub(:find_by_isbn).and_return(@fake_book)
				Requirement.stub(:create)
				put :create_new_book, {:id => @fake_course.id, :title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}
			end
			it 'should create a new requirement object to make the newly created book an unrequired book of the given course' do
				Course.stub(:find).and_return(@fake_course)
				Book.stub(:create)
				Book.stub(:find_by_isbn).and_return(@fake_book)
				Requirement.should_receive(:create).with(:course_id => @fake_course.id, :book_id => @fake_book.id, :is_required => false)
				put :create_new_book, {:id => @fake_course.id, :title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}
			end
			it 'should redirect to the create new posting page of the newly created book' do
				Course.stub(:find).and_return(@fake_course)
				Book.stub(:create)
				Book.should_receive(:find_by_isbn).with(@fake_book.isbn).and_return(@fake_book)
				Requirement.stub(:create)
				put :create_new_book, {:id => @fake_course.id, :title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}
				response.should redirect_to(display_new_posting_path(@fake_book.id))
			end
		end
		it 'fail path' do
			describe 'the given course is not an existing course' do
				it 'should not call the create method or the find_by_isbn method in the Book model and should not call the create method in the Requirment model' do
				Course.stub(:find).and_return(nil)
				end
			end
			describe 'the entered book information does not pass validation' do
			end
		end
	end
	describe 'show_postings' do
		it 'should call the find method in the Book model to find the book refered to by the id param' do
			Book.should_receive(:find).with(@fake_book.id).and_return(@fake_book)
			Book.stub(:find).and_return(@fake_book)
			get :show_postings, {:id => @fake_book.id}
		end
		it "should make the list of this book's non-expired postings available to the view in the @postings variable" do
			Book.stub(:find).and_return(@fake_book)
			@fake_book.should_receive(:postings).and_return(@postings)
			BooksController.stub(:expire_period).and_return(2.days)
			get :show_postings, {:id => @fake_book.id}
			assigns(:postings).should == @non_expired_postings
		end
		it "should make the book available to the view in the @book variable" do
			Book.stub(:find).and_return(@fake_book)
			@fake_book.stub(:postings).and_return(@postings)
			get :show_postings, {:id => @fake_book.id}
			assigns(:book).should == @fake_book
		end
		it 'should render the show_postings view' do
			Book.stub(:find).and_return(@fake_book)
			@fake_book.stub(:postings).and_return(@postings)
			get :show_postings, {:id => @fake_book.id}
			response.should render_template("show_postings")
		end
	end
end
