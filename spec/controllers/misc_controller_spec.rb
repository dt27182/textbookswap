require 'spec_helper'

describe MiscController do

  describe 'the admin page' do
    describe 'viewing the admin page' do
      before(:each) do
        @semester = Misc.find_by_key("semester").value
        @year = Misc.find_by_key("year").value
        @expiration_period = Misc.find_by_key("expiration_time").value
        session[:user_id] = 1
      end
    
      it 'should redirect to the index page if no one is not logged in' do
        session[:user_id] = nil
        get :display
        response.should redirect_to(index_path())
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
        assings(:expiration_time).should == @expiration_period
      end
    end
    
    describe 'updating the values' do
      it 'should update the current semester' do
        post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
        Misc.find_by_key("semester").value.should == "fall"
      end
      
      it 'should update the current year' do
        post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
        Misc.find_by_key("year").value.should == 2012
      end
      
      it 'should update the expiration period' do
        post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
        Misc.find_by_key("expiration_time").value.should == "24"
      end
      
      it "should set the flash message" do
        post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
        flash.now[:notice].should == "Settings Saved!"
      end
      
      describe "fail path" do
      
        before :each do
          session[:user_id] = nil
        end
      
        it "should fail if there is no one logged in" do
          post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
          response.should redirect_to(index_path())
        end
        
        it "should set the flash" do
          post :commit_edit, {:semester => "fall", :year => "2012", :expiration_time => "24"}
          flash.now[:warning].should == "You do not have privileges to update these values"
        end
        
      end
        
    end
  end

end
