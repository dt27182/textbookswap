require 'spec_helper'

describe MiscController do

  describe 'the admin page' do
  
    before(:each) do
      @semester = Misc.create!(:key => "semester", :value => "spring").value
      @year = Misc.create!(:key => "year", :value => "2012").value
      @expiration_time = Misc.create!(:key => "expiration_time", :value => "90").value
      session[:user_id] = 1
    end
      
    describe 'viewing the admin page' do
    
      it 'should redirect to the index page if no one is not logged in' do
        session[:user_id] = nil
        get :display
        response.should redirect_to("/auth/facebook")
      end
      
      it 'should make the current semester available to the view' do
        get :display
        assigns(:semester).should == @semester
      end
      
      it 'should make the current year available to the view' do
        get :display
        assigns(:year).should == @year
      end
      
      it 'should make the current expiration period available to the view' do
        get :display
        assigns(:expiration_time).should == @expiration_time
      end
    end
    
    describe 'updating the values' do
    
      before :each do
        Course.stub(:get_courses_for)
        Book.stub(:get_books)
        time = Time.new
        @next_year = (time.year.to_i + 1.year.to_i).to_s
      end
      
      it 'should update the current semester' do
        post :commit_edit, {:misc => {:semester => "fall", :year => "2012", :expiration_time => "24"}}
        Misc.find_by_key("semester").value.should == "fall"
      end
      
      it 'should update the current year' do
        post :commit_edit, {:misc => {:semester => "fall", :year => @next_year.to_s, :expiration_time => "24"}}
        Misc.find_by_key("year").value.should == @next_year.to_s
      end
      
      it 'should update the expiration period' do
        post :commit_edit, {:misc => {:semester => "fall", :year => "2012", :expiration_time => "24"}}
        Misc.find_by_key("expiration_time").value.should == "24"
      end
      
      it "should set the flash message" do
        post :commit_edit, {:misc => {:semester => "fall", :year => "2012", :expiration_time => "24"}}
        flash.now[:notice].should == "Settings Saved!"
      end
      
      describe "fail path" do
      
        before :each do
          session[:user_id] = nil
        end
      
        it "should fail if there is no one logged in" do
          post :commit_edit, {:misc => {:semester => "fall", :year => "2012", :expiration_time => "24"}}
          response.should redirect_to(index_path())
        end
        
        it "should set the flash" do
          post :commit_edit, {:misc => {:semester => "fall", :year => "2012", :expiration_time => "24"}}
          flash.now[:warning].should == "You do not have privileges to update these values."
        end
        
      end
        
    end
  end

end
