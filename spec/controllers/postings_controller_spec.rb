require 'spec_helper'

describe PostingsController do

#  describe "GET 'show'" do
#    it "returns http success" do
#      get 'show'
#      response.should be_success
#    end
#  end

  before :each do
    @fake_post = mock('Posting', :id => '1', :seller_email => "abc@abc.com", :seller_name => "Seller", :price => "30", :location => "South Side", :condition => "New", :comment => "Only used this book before my exams", :book_id => '1')
    @fake_book = mock('Book', :id => '1', :title => "Book", :author => "Professor", :edition => "1")
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
  
    #posting_id is the primary id but we call it posting_id since there are two ids on this page (book_id, posting_id)
  
    describe "correct path" do
  
      it "should call the finb_by_id_and_book_id to find the Posting" do   
        Posting.should_receive(:find_by_id).with(:id => '1').and_return([@fake_post])
        get :show, {:posting_id => '1'}
      end
    
      it "should call find_by_id to find the Book" do
        Posting.stub(:find_by_id).and_return([@fake_post])
        Book.should_receive(:find_by_id).with(:id => [@fake_post.book_id]).and_return([@fake_book])
        get :show, {:posting_id => '1'}
      end
    
      it "book_id of Posting and the input book_id should match" do
        Posting.stub(:find_by_id).and_return([@fake_post])
        Book.stub(:find_by_id).and_return([@fake_book])
        [@fake_book.id].should == '1'
        get :show, {:posting_id => '1'}
      end
    
      it "should get the posting info of Posting" do
        Posting.stub(:find_by_id).and_return([@fake_post])
        get :show, {:posting_id => '1'}
        assigns(:post).should == [@fake_post]
      end
    
      it "should get the book info of Book" do
        Book.stub(:find_by_id).and_return([@fake_book])
        get :show, {:posting_id => '1'}
        assigns(:book).should == [@fake_book]
      end
    
      it "should render to the correct posting" do
        Posting.stub(:find_by_id).and_return([@fake_post])
        get :show, {:posting_id => '1'}
        response.should render_template(show_posting_path('1', '1'))
      end
      
    end
    
    describe "wrong path" do
        
      it "should not render to the wrong posting" do
        Posting.stub(:find_by_id_and_book_id).and_return([@fake_post])
        get :show, {:posting_id => '1'}
        response.should_not render_template(show_posting_path('2'))
      end
      
    end

  end
  
  describe "commit_buy method" do
      
    before :each do
			@fake_buyer_name = "Buyer"
			@fake_buyer_email = "def@def.com"
			@fake_buyer_phone = "111-111-1111"
			@fake_buyer_comment = "Hello, I want to buy your book"
			@empty_buyer_name = ""
		  @empty_buyer_email = ""
			@empty_buyer_phone = ""
			@empty_buyer_comment = ""
			@seller_email = "abc@abc.com"
			@book_title = "TextBook"
		end
      
    describe "correct inputs" do
      
      before :each do
        @message = "Name: #{@fake_buyer_name}\nEmail: #{@fake_buyer_email}\nPhone: #{@fake_buyer_phone}\n\n#{@fake_buyer_comment}"
        @subject = "[TextBook Swap] - Interested in #{@book_title}"
      end
      
      it "should send an email to the seller" do
        Posting.should_receive(:send_seller_buyer_info).with(:to => @seller_email, :subject => @subject, :body => @fake_buyer_comment)
        post :commit_buy, {:posting_id => '1'}
      end    
      
      it "should redirect back to the home page with correct inputs" do  
        Posting.stub(:send_seller_buyer_info)
        post :commit_buy, {:posting_id => '1'}
        response.should redirect_to(index_path())
      end
      
    end
    
    describe "empty inputs" do
    
      before :each do
        @message = "Name: #{@empty_buyer_name}\nEmail: #{@empty_buyer_email}\nPhone: #{@empty_buyer_phone}\n\n#{@empty_buyer_comment}"
        @subject = "[TextBook Swap] - Interested in #{@book_title}"
      end
      
      it "should not send an email to the Seller if the Buyer tries to buy without info" do
        Posting.should_not_receive(:send_seller_buyer_info).with(:to => @seller_email, :subject => @subject, :body => @empty_buyer_comment)
        post :commit_buy, {:posting_id => '1'}
      end
      
      it "should redirect back to the same page with empty inputs" do
        Posting.should_not_receive(:send_seller_buyer_info).with(:to => @seller_email, :subject => @subject, :body => @empty_buyer_comment)
        post :commit_buy, {:posting_id => '1'}
        response.should redirect_to(show_posting_path('1', '1'))
      end
            
    end
    
  end
  
  describe "display_new method" do
      
    describe "correct book id" do
      
      it "should call find_by_id to find the Book" do
        Book.should_receive(:find_by_id).with(:id => '1').and_return([@fake_book])
        get :display_new,  {:book_id => '1'}
      end
    
      it "should call put book data" do
        Book.stub(:find_by_id).and_return([@fake_book])
        get :display_new,  {:book_id => '1'}
        assigns(:book).should == [@fake_book]
      end
    
    end
    
    describe "incorrect book id" do
    
      it "should call put book data" do
        Book.stub(:find_by_id).and_return([])
        get :display_new,  {:book_id => '-1'}
        assigns(:book).should == []
        response.should render_template(index_path())
      end
    
    end
    
  end
  
  describe "create_new method" do

    describe "correct inputs" do

      it "should call create" do
        Posting.should_receive(:create).with(:seller_email => [@fake_posting.seller_email], :seller_name => [@fake_posting.seller_name], :price => [@fake_posting.price], :location => [@fake_posting.location], :condition => [@fake_condition], :book_id => '1')
        put :create_new, {:book_id => '1'}
      end
    
      it "should redirect back to the home page" do
        Posting.stub(:create)
        put :create_new, {:book_id => '1'}
        response.should redirect_to(index_path())
      end
    
    end
    
    describe "empty inputs" do
    
      before :each do 
        @empty_post = mock('Posting', :seller_email => "", :seller_name => "", :price => "", :location => "", :condition => "", :comment => "", :book_id => '1')
      end
        
      it "should not actually create the posting and redirect back to itself" do
        Posting.should_receive(:create).with(:seller_email => "", :seller_name => "", :price => "", :location => "", :condition => "", :book_id => '1')
        put :create_new, {:book_id => '1'}
        @empty_post.should_not be_valid
        response.should redirect_to(create_new('1'))
      end
      
    end
    
  end

end
