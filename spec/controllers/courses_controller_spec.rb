require 'spec_helper'

describe CoursesController do

  before :each do
    @fake_course = mock('Course', :id => '1', :name => "CS", :number => "169")
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end
  
  describe "buyer choosing a course and course number" do
  
    it "should call find_by_name_and_number" do
      Course.should_receive(:find_by_name_and_number)
      get "buy_find_books", {:id => '1'}
    end
    
    it "should return the correct course" do
      Course.stub(:find_by_name_and_number).with("CS", "169").and_return(@fake_course)
      get "buy_find_books", {:id => '1'}
    end
  
    it "should render to the buyer's book listings page" do
      response.should render_template('/buy/course/:1/book/show')
      get "buy_find_books", {:id => '1'}
    end
    
    it "should not render to the seller's book listings page" do
      response.should_not render_template('/sell/course/:1/book/show')
      get "buy_find_books", {:id => '1'}
    end
  
  end
  
  describe "seller choosing a course and course number" do
  
    it "should call find_by_name_and_number" do
      Course.should_receive(:find_by_name_and_number)
      get "sell_find_books", {:id => '1'}
    end
    
    it "should return the correct course" do
      Course.stub(:find_by_name_and_number).with("CS", "169").and_return(@fake_course)
      get "sell_find_books", {:id => '1'}
    end
  
    it "should render to the seller's book listings page" do
      response.should render_template('/sell/course/:1/book/show')
      get "sell_find_books", {:id => '1'}
    end
    
    it "should not render to the buyer's book listings page" do
      response.should_not render_template('/buy/course/:1/book/show')
      get "sell_find_books", {:id => '1'}
    end
  
  end
  
end
