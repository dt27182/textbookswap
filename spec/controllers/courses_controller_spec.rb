require 'spec_helper'

describe CoursesController do

  before :each do
    @fake_course = mock('Course', :id => '1', :department_long => "CS", :number => "169")
  end
	describe "find" do  
  	describe "after buyer chooses a course and course number" do
    	it "should call the find method in the courses controller" do
      	CoursesController.should_receive(:find)
      	post :find, {:transaction_type => 'buy', :department_long => 'Computer Science', :number => '169'}
    	end
  		it "should call the find_by_department_long_and_number method in the Course model" do
  			Course.should_receive(:find_by_department_long_and_number).with('Computer Science', '169')
  			post :find, {:transaction_type => 'buy', :department_long => 'Computer Science', :number => '169'}
  		end
  		describe "success path" do
    		it "should redirect to the buyer's show books page" do
      		response.should redirect_to(show_books_path('buy','1'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(@fake_course)
      		post :find, {:transaction_type => 'buy', :department_long => 'Computer Science', :number => '169'}
    		end
    		
    		it "should not redirect to the seller's book listings page" do
      		response.should_not redirect_to(show_books_path('sell','1'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(@fake_course)
      		post :find, {:transaction_type => 'buy', :department_long => 'Computer Science', :number => '169'}
    		end
  		end
  		describe "fail path" do
  			it "should redirect to the select a course page" do
  				response.should redirect_to(show_courses_path('buy'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(nil)
      		post :find, {:transaction_type => 'buy', :department_long => 'Computer Science', :number => '169'}
  			end
  		end
  	end

  	describe "after seller chooses a course and course number" do
    	it "should call the find method in the courses controller" do
      	CoursesController.should_receive(:find)
      	post :find, {:transaction_type => 'sell', :department_long => 'Computer Science', :number => '169'}
    	end
  		it "should call the find_by_department_long_and_number method in the Course model" do
  			Course.should_receive(:find_by_department_long_and_number).with('Computer Science', '169')
  			post :find, {:transaction_type => 'sell', :department_long => 'Computer Science', :number => '169'}
  		end
  		describe "success path" do
    		it "should redirect to the seller's show books page" do
      		response.should redirect_to(show_books_path('sell','1'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(@fake_course)
      		post :find, {:transaction_type => 'sell', :department_long => 'Computer Science', :number => '169'}
    		end
    		
    		it "should not redirect to the buyer's book listings page" do
      		response.should_not redirect_to(show_books_path('sell','1'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(@fake_course)
      		post :find, {:transaction_type => 'sell', :department_long => 'Computer Science', :number => '169'}
    		end
  		end
  		describe "fail path" do
  			it "should redirect to the select a course page" do
  				response.should redirect_to(show_courses_path('sell'))
      		Course.stub(:find_by_deparement_long_and_number).and_return(nil)
      		post :find, {:transaction_type => 'sell', :department_long => 'Computer Science', :number => '169'}
  			end
  		end
  	end
  end
  
  describe "show_books" do
  	describe "buy path" do   		
    	it "should call the CoursesController's show_books method" do
    		CoursesController.should_receive(:show_books)
      	get :show_books, {:transaction_type => 'buy', :id => '1'}
    	end
    		
    	it "should call the find_by_id method in the Course model" do
    		Course.should_receive(:find_by_id).with('1')
      	get :show_books, {:transaction_type => 'buy', :id => '1'}
    	end
    		
    	it "should call the find_required_and_unrequired_books method in the Course model" do
    		Course.stub(:find_by_id).and_return(@fake_course)
    		Course.should_receive(:find_required_and_unrequired_books).with('1')
    		get :show_books, {:transaction_type => 'buy', :id => '1'}
    	end
    	describe "sucess path" do
    		
    	end
    	describe "fail path" do
    		
    	end
    end
  end
  
end
