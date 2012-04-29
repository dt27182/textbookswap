require 'spec_helper'

describe PostingsController do

#  describe "GET 'show'" do
#    it "returns http success" do
#      get 'show'
#      response.should be_success
#    end
#  end

  before :each do
    @fake_post = Posting.create!({:seller_email => "abc@gmail.com", :seller_name => "Seller", :price => 30, :location => "South Side", :condition => "New", :comments => "Only used this book before my exams", :reserved => false, :book_id => '1'})
    @fake_post.book_id = '1'
    @fake_post.save!
    @fake_book = Book.create!({:title => "Book", :author => "Professor", :edition => "1", :isbn => "960-425-059-0"})
  end

  describe "The route" do

    it "should call show" do
      get :show, {:posting_id => '1'}
      response.should be_success
    end

    it "should call display_new" do
      get :display_new, {:book_id => '1'}
      response.should be_success
    end

  end

  describe "show method" do

    describe "correct path" do

      it "should call the find_by_id to find the Posting" do
        Posting.should_receive(:find_by_id).with("1").and_return(@fake_post)
        get :show, {:posting_id => '1'}
      end

      it "book_id of Posting and the input book_id should match" do
        Posting.stub(:find_by_id).and_return(@fake_post)
        Book.stub(:find_by_id).and_return(@fake_book)
        @fake_book.id.should == 1
        get :show, {:posting_id => '1'}
      end

      it "should make the posting variable available to the view" do
        Posting.stub(:find_by_id).and_return(@fake_post)
        get :show, {:posting_id => '1'}
        assigns(:posting).should == @fake_post
      end

      it "should make the book variable available to the view" do
        Book.stub(:find_by_id).and_return(@fake_book)
        get :show, {:posting_id => '1'}
        assigns(:book).should == @fake_book
      end

      it "should render to the correct posting" do
        Posting.stub(:find_by_id).and_return(@fake_post)
        get :show, {:posting_id => '1'}
        response.should render_template("show")
      end

    end

    describe "wrong path" do

      it "should redirect to the wrong posting" do
        Posting.stub(:find_by_id).and_return(nil)
        get :show, {:posting_id => '-1'}
        response.should redirect_to(index_path())
      end

    end

  end

  describe "commit_buy method" do

    before :each do
      @fake_buyer_name = "Buyer"
      @fake_buyer_email = "def@gmail.com"
      @fake_buyer_comment = "Hello, I want to buy your book"
      @empty_buyer_name = ""
      @empty_buyer_email = ""
      @empty_buyer_comment = ""
      @seller_email = "abc@gmail.com"
    end

    describe "correct inputs" do

      before :each do
        @message = "Name: #{@fake_buyer_name}\nEmail: #{@fake_buyer_email}}\n\n#{@fake_buyer_comment}"
      end

      it "should send an email to the seller" do
        Posting.stub(:find_by_id).and_return(@fake_post)
        @fake_post.should_receive(:send_seller_buyer_info).with(@fake_buyer_email, @fake_buyer_comment)
        post :commit_buy, {:posting_id => '1', :email => {:body => @fake_buyer_comment, :buyer_email => @fake_buyer_email}}
      end

      it "should redirect back to the home page with correct inputs" do
      	Posting.stub(:find_by_id).and_return(@fake_post)
        @fake_post.stub(:send_seller_buyer_info)
        post :commit_buy, {:posting_id => '1', :email => {:body => @fake_buyer_comment, :buyer_email => @fake_buyer_email}}
        response.should redirect_to(index_path())
      end
      
      it "should reserve the post when bought" do
      	Posting.stub(:find_by_id).and_return(@fake_post)
        @fake_post.stub(:send_seller_buyer_info)
        post :commit_buy, {:posting_id => '1', :email => {:body => @fake_buyer_comment, :buyer_email => @fake_buyer_email}}
        @fake_post.reserved.should == true
      end

    end

    describe "empty inputs" do

      before :each do
        @message = "Name: #{@empty_buyer_name}\nEmail: #{@empty_buyer_email}\n\n#{@empty_buyer_comment}"
      end

      it "should not send an email to the Seller if the Buyer tries to buy without info" do
        Posting.should_not_receive(:send_seller_buyer_info).with(@empty_buyer_comment)
        post :commit_buy, {:posting_id => '1', :email => {:body => @empty_buyer_comment}}
      end

      it "should redirect back to the same page with empty inputs" do
        Posting.should_not_receive(:send_seller_buyer_info).with(@empty_buyer_comment)
        post :commit_buy, {:posting_id => '1', :email => {:body => @empty_buyer_comment}}
        response.should redirect_to(show_posting_path('1'))
      end

    end

    describe "wrong inputs" do
      it "should set the flash if can't find posting" do
        post :commit_buy, {:posting_id => '6', :email => {:body => @fake_buyer_comment, :buyer_email => @fake_buyer_email}}
        flash.now[:warning].should == "Buy request failed because the given post id does not exist"
      end

      it "should set the flash if the email isn't right" do
        post :commit_buy, {:posting_id => '1', :email => {:body => @fake_buyer_comment, :buyer_email => "gibberish"}}
        flash.now[:warning].should == "Please fill in the required fields"
      end

    end

  end

  describe "display_new method" do

    describe "correct book id" do

      it "should call find_by_id to find the Book" do
        Book.should_receive(:find_by_id).with('1').and_return(@fake_book)
        get :display_new,  {:book_id => '1'}
      end

      it "should make the book variable available to the view" do
        Book.stub(:find_by_id).and_return(@fake_book)
        get :display_new,  {:book_id => '1'}
        assigns(:book).should == @fake_book
      end

    end

    describe "incorrect book id" do

      it "should redirect to the index" do
        Book.stub(:find_by_id).and_return(nil)
        get :display_new,  {:book_id => '-1'}
        response.should redirect_to(index_path())
      end

    end

  end

  describe "create_new method" do

    describe "correct inputs" do

      it "should check if the book exists" do
        Book.should_receive(:find_by_id).with('1').and_return(@fake_book)
        put :create_new, {:book_id => '1', :posting => {:seller_email => "abc@abc.com", :seller_name => "Alice", :price => "21", :location => "Berkeley"}}
      end

      it "should call create" do
        Posting.should_receive(:create).with("seller_email" => @fake_post.seller_email, "seller_name" => @fake_post.seller_name, "price" => @fake_post.price.to_s, "location" => @fake_post.location, "condition" => @fake_post.condition, "book_id" => 1).and_return(@fake_post)
        put :create_new, {:book_id => '1', :posting => {:seller_email => @fake_post.seller_email, :seller_name => @fake_post.seller_name, :price => @fake_post.price, :location => @fake_post.location, :condition => @fake_post.condition, :book_id => '1'}}
      end
      
      it "should send an email to the seller" do
        Posting.stub(:create).and_return(@fake_post)
        UserMailer.should_receive(:send_seller_admin_page)
        put :create_new, {:book_id => '1', :posting => {:seller_email => "abc@abc.com", :seller_name => "Alice", :price => "21", :location => "Berkeley"}}
      end

      it "should redirect back to the home page" do
        Posting.stub(:create).and_return(@fake_post)
        put :create_new, {:book_id => '1', :posting => {:seller_email => "abc@abc.com", :seller_name => "Alice", :price => "21", :location => "Berkeley"}}
        response.should redirect_to(index_path())
      end

    end

    describe "empty inputs" do

      before :each do
        @empty_post = mock('Posting', :seller_email => "", :seller_name => "", :price => "", :location => "", :condition => "", :comment => "", :book_id => '1')
      end

      it "should fail if the book does not exist" do
        Book.stub(:find_by_id).and_return(nil)
        put :create_new, {:book_id => '-1', :posting => {:seller_email => "abc@abc.com", :seller_name => "Alice", :price => "21", :location => "Berkeley"}}
        response.should redirect_to(index_path())
      end

      it "should not actually create the posting and redirect back to itself" do
        Posting.stub(:create).with(:seller_email => "", :seller_name => "", :price => "", :location => "", :condition => "", :book_id => '1')
        Posting.stub(:errors).and_return(:seller_email => ["Cannot be empty"])
        put :create_new, {:book_id => '1', :posting => {:seller_email => "", :seller_name => "Alice", :price => "21", :location => "Berkeley"}}
        response.should redirect_to(display_new_posting_path('1'))
      end

    end

  end
  
  describe "admin method" do
  
    before(:each) do
      Posting.stub(:decrypt).and_return(1)
      Posting.stub(:find_by_id).and_return(@fake_post)
    end
  
    it "should convert the unique string to a posting id" do
      Posting.should_receive(:decrypt).with("dsaf23lkj23")
      get :admin, {:unique_string => "dsaf23lkj23"}
    end
    
    it "should call for the posting id" do
      Posting.should_receive(:find_by_id).and_return(@fake_post)
      get :admin, {:unique_string => "dsaf23lkj23"}
    end
    
    it "should redirect to the homepage if ther is no posting with that id" do
      Posting.stub(:find_by_id).and_return(nil)
      get :admin, {:unique_string => "dsaf23lkj23"}
      response.should redirect_to(index_path())
    end
    
    it "should make the posting available to the view" do
      get :admin, {:unique_string => "dsaf23lkj23"}
      assigns(:posting).should == @fake_post
    end
    
    it "should make the book on that posting available to the view" do
      get :admin, {:unique_string => "dsaf23lkj23"}
      assigns(:book).should == @fake_book
    end
    
  end
  
  describe "commit_edit method" do
  	before(:each) do
      Posting.stub(:decrypt).and_return(1)
      Posting.stub(:find_by_id).and_return(@fake_post)
      @new_post_info = {:seller_email => "cba@gmail.com", :seller_name => "Epic Seller", :price => 40, :location => "North Side", :condition => "Destroyed", :comments => "I love this book"}
    end
    it "should convert the unique string to a posting id" do
      Posting.should_receive(:decrypt).with("dsaf23lkj23")
      post :commit_edit, {:unique_string => "dsaf23lkj23"}
    end
    it "should call for the posting id" do
      Posting.should_receive(:find_by_id).and_return(@fake_post)
      post :commit_edit, {:unique_string => "dsaf23lkj23"}
    end
    it "should redirect to the homepage if there is no posting with that id" do
      Posting.stub(:find_by_id).and_return(nil)
      post :commit_edit, {:unique_string => "dsaf23lkj23"}
      response.should redirect_to(index_path())
    end
    it "should call the update_attributes method in the posting model" do
    	Posting.should_receive(:update_attributes).with(@new_post_info)
    	post :commit_edit, {:unique_string => "dsaf23lkj23", :new_post => @new_post_info}
    end
    it "should redirect to the homepage if the update fails" do
    end
    it "should redirect to the show posting page if the update succeeds"do
    end
    
  end
  describe "delete method" do
  
    before(:each) do
      session[:user_id] = 1
      Posting.stub(:find_by_id).and_return(@fake_post)
    end
  
    it "should call for the posting by id" do
      Posting.should_receive(:find_by_id).and_return(@fake_post)
      delete :delete, {:unique_string => "daj2390lkafj"}
    end
    
    it "should call destroy on the posting" do
      @fake_post.should_receive(:destroy)
      delete :delete, {:unique_string => "daj2390lkafj"}
    end
    
    it "should redirect to the homepage" do
      delete :delete, {:unique_string => "daj2390lkafj"}
      response.should redirect_to(index_path())
    end
    
    it "should still delete if not admin but comes from the postings page" do
      @fake_post.should_receive(:destroy)
      delete :delete, {:unique_string => "daj2390lkafj"}
    end  
    
    describe "fail path" do
    
      it "should redirect to the posting page if not an admin or have secret key" do
        session[:user_id] = nil
        response.should redirect_to(show_posting_path(1))
      end
      
    end
    
  end
    
  describe "republishing" do
    
    before :each do
      Posting.stub(:decrypt).and_return(1)
    end
    
    it "should reset the reserved boolean for the posting to true" do
      post :republish, {:unique_string => "random"}
      @fake_post.reserved.should == true
    end
  
    it "should republish it should go to the posting page" do
      post :republish, {:unique_string => "random"}
      response.should redirect_to(show_posting(1))
    end
      
  end

end
