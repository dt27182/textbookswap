require 'spec_helper'

describe BooksController do
  before :each do
    @fake_course = mock('Course', :id => '1')
    @fake_book = mock('Book', :id => '1', :title => 'testbook1', :author => 'bob', :edition => '1', :isbn => '99921-58-10-7')
    @fake_book_2 = Book.create({:title => "testbook2", :author => "alice", :edition => "2", :isbn => "9971-5-0210-0"})
    @posting1 = Posting.create!({:seller_email => "abc@gmail.com", :seller_name => "Seller", :price => 30, :location => "South Side", :condition => "New", :comments => "Only used this book before my exams", :reserved => false})
    @posting1.updated_at = Time.now
    @posting1.book_id = 2
    @posting1.save!
    @posting2 = Posting.create!({:seller_email => "abc@gmail.com", :seller_name => "Seller", :price => 30, :location => "South Side", :condition => "New", :comments => "Only used this book before my exams", :reserved => false})
    @posting2.updated_at = Time.now - 3.days
    @posting2.book_id = 2
		@posting2.save!
		@posting3 = Posting.create!({:seller_email => "abc@gmail.com", :seller_name => "Seller", :price => 30, :location => "South Side", :condition => "New", :comments => "Only used this book before my exams", :reserved => false})
		@posting3.book_id = 2
		@posting3.reserved = true
		@posting3.save!
    @postings = [@posting1, @posting2, @posting3]
    @valid_postings = [@posting1]
    Misc.create({:key => "expiration_time", :value => "2"})
  end

  describe 'display_new' do
    it 'should check if the given course exists' do
      Course.should_receive(:find_by_id).with(@fake_course.id)
      get :display_new, {:id => @fake_course.id}
    end
    describe 'success path' do
      it 'should render the display_new view' do
        Course.stub(:find_by_id).and_return(@fake_course)
        get :display_new, {:id => @fake_course.id}
        response.should render_template("display_new")
      end
    end
    describe 'fail path' do
      it 'should redirect to the home page' do
        Course.stub(:find_by_id).and_return(nil)
        get :display_new, {:id => "2"}
        response.should redirect_to(index_path)
      end
    end
  end

  describe 'create_new' do
    it 'should check if the book already exists in the database' do
    		Course.stub(:find_by_id).and_return(@fake_course)
    		Book.should_receive(:find).with(:first, :conditions => ["title = :title AND author = :author AND edition = :edition AND isbn = :isbn", {"title" => @fake_book.title, "author" => @fake_book.author, "edition" => @fake_book.edition, "isbn" => @fake_book.isbn}])
    		Requirement.stub(:create)
		    put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
    end
    describe 'success path' do
    	describe "book doesn't already exist in the database" do
		    it 'should call the create method in the Book model' do
		      Course.stub(:find_by_id).and_return(@fake_course)
		      Book.should_receive(:create).with({"title" => @fake_book.title, "author" => @fake_book.author, "edition" => @fake_book.edition, "isbn" => @fake_book.isbn}).and_return(@fake_book)
		      Book.stub(:find).and_return(nil)
		      Requirement.stub(:create)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		    end
		    it 'should create a new requirement object to make the newly created book an unrequired book of the given course' do
		      Course.stub(:find_by_id).and_return(@fake_course)
		      Book.stub(:create).and_return(@fake_book)
		      Book.stub(:find).and_return(nil)
		      Requirement.should_receive(:create).with(:course_id => @fake_course.id, :book_id => @fake_book.id, :is_required => false)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		    end
		    it 'should redirect to the create new posting page of the newly created book' do
		      Course.stub(:find_by_id).and_return(@fake_course)
		      Requirement.stub(:create)
		      Book.stub(:find).and_return(nil)
		      Book.stub(:create).and_return(@fake_book)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		      response.should redirect_to(display_new_posting_path(@fake_book.id))
		    end
		  end
		  describe "book already exists in the database" do
		  	it 'should not create a new book' do
		  		Course.stub(:find_by_id).and_return(@fake_course)
		      Book.stub(:find).and_return(@fake_book)
		      Book.should_not_receive(:create)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		  	end
		  	it 'should create a new requirement object to make the already created book an unrequired book of the given course' do
		      Course.stub(:find_by_id).and_return(@fake_course)
		      Book.stub(:find).and_return(@fake_book)
		      Requirement.should_receive(:create).with(:course_id => @fake_course.id, :book_id => @fake_book.id, :is_required => false)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		    end
		    it 'should redirect to the create new posting page of the already created book' do
		      Course.stub(:find_by_id).and_return(@fake_course)
		      Requirement.stub(:create)
		      Book.stub(:find).and_return(@fake_book)
		      put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
		      response.should redirect_to(display_new_posting_path(@fake_book.id))
		    end
		  end
		end
    describe 'fail path' do
      describe 'the given course is not an existing course' do
        it 'should not call the create method or the find_by_isbn method in the Book model and should not call the create method in the Requirment model' do
          Course.stub(:find_by_id).and_return(nil)
          Book.should_not_receive(:create)
          Book.should_not_receive(:find_by_isbn)
          Requirement.should_not_receive(:create)
          put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
        end
        it 'should redirect to the homepage' do
          Course.stub(:find_by_id).and_return(nil)
          Book.stub(:create)
          Book.stub(:find_by_isbn)
          Requirement.stub(:create)
          put :create_new, {:id => @fake_course.id, :book => {:title => @fake_book.title, :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
          response.should redirect_to(index_path)
        end
      end
      describe 'the entered book information does not pass validation' do
        it 'should not call the find_by_isbn method in the Book model and should not call the create method in the Requirment model' do
          Course.stub(:find_by_id).and_return(@fake_course)
          Book.stub(:errors).and_return({:title=>["can't be blank"]})
          Book.should_not_receive(:find_by_isbn)
          Requirement.should_not_receive(:create)
          put :create_new, {:id => @fake_course.id, :book => {:title => "", :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
        end
        it 'should redirect to the create new book page' do
          Course.stub(:find_by_id).and_return(@fake_course)
          Book.stub(:errors).and_return({:title=>["can't be blank"]})
          Book.should_not_receive(:find_by_isbn)
          Requirement.should_not_receive(:create)
          put :create_new, {:id => @fake_course.id, :book => {:title => "", :author => @fake_book.author, :edition => @fake_book.edition, :isbn => @fake_book.isbn}}
          response.should redirect_to(display_new_book_path(@fake_course.id))
        end
      end
    end
  end

  describe 'show_postings' do
    describe 'success path' do
      it 'should call the find method in the Book model to find the book refered to by the id param' do
        Book.should_receive(:find_by_id).with(@fake_book_2.id.to_s).and_return(@fake_book_2)
        get :show_postings, {:book_id => @fake_book_2.id}
      end
      it "should make the list of this book's non-expired and non-reserved postings available to the view in the @postings variable" do
        Book.stub(:find_by_id).and_return(@fake_book_2)
        @fake_book_2.should_receive(:postings).and_return(@postings)
        get :show_postings, {:book_id => @fake_book_2.id}
        assigns(:postings).should == @valid_postings
      end
      it "should make the book available to the view in the @book variable" do
        Book.stub(:find_by_id).and_return(@fake_book_2)
        @fake_book_2.stub(:postings).and_return(@postings)
        get :show_postings, {:book_id => @fake_book_2.id}
        assigns(:book).should == @fake_book_2
      end
      it 'should render the show_postings view' do
        Book.stub(:find_by_id).and_return(@fake_book_2)
        @fake_book_2.stub(:postings).and_return(@postings)
        get :show_postings, {:book_id => @fake_book_2.id}
        response.should render_template("show_postings")
      end
    end
    describe 'fail path' do
      it 'should redirect to the home page if the given book does not exist' do
        Book.stub(:find_by_id).and_return(nil)
        get :show_postings, {:book_id => "23"}
        response.should redirect_to(index_path)
      end
    end
  end
end
