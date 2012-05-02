require 'spec_helper'

describe UsersController do

  describe "adding a new user" do
  
    before :each do
      @new_email = "atkaiser@berkeley.edu"
      session[:user_id] = 1
    end
  	
    it "should call create on the User model" do
      User.should_receive(:create).with({:email => @new_email}).and_return(mock(:User, :id => 3))
      put :new, {:user => {:email => @new_email}}
    end
    
    it "should redirect to the admin page" do
      put :new, {:user => {:email => @new_email}}
      response.should redirect_to(display_admin_page_path())
    end
    
    it "should set the flash message" do
      put :new, {:user => {:email => @new_email}}
      flash.now[:notice].should == "User added"
    end
    
    describe "fail path" do
    
      before :each do
        session[:user_id] = nil
      end
      
      it "should redirect to the index page" do
        put :new, {:email => @new_email}
        response.should redirect_to(index_path())
      end
      
      it "should set the flash message" do
        put :new, {:email => @new_email}
        flash.now[:warning].should == "You do not have the privilege to add a new user."
      end
    
    end
        
  end

end
