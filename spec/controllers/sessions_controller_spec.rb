require 'spec_helper'

describe SessionsController do
	describe "create method" do
		it "should get the authentication hash from omniauth"do
			request.should_receive(:env).at_least(1).times.and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
			get "create", {:provider => "facebook" }
		end
		it "should check to see if the user already exists" do
			request.stub(:env).and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
			User.should_receive(:find_by_email)
			get "create", {:provider => "facebook" }
		end
		describe "success path" do
			it "should redirect to the admin page" do
				request.stub(:env).and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
				User.stub(:find_by_email).and_return(mock(:User, :id => 1))
				get "create", {:provider => "facebook" }
				response.should redirect_to(display_admin_page_path())
			end
			it "should store the user id in the sessions hash" do
				request.stub(:env).and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
				User.stub(:find_by_email).and_return(mock(:User, :id => 1))
				get "create", {:provider => "facebook" }
				session[:user_id].should == 1
			end
		end
		describe "fail path" do
			it "should redirect to the index page" do
				request.stub(:env).and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
				User.stub(:find_by_email)
				get "create", {:provider => "facebook" }
				response.should redirect_to(index_path)
			end
			it "should put a failure message in the flash hash" do
				request.stub(:env).and_return({"omniauth.auth" => {"info" => {"email" => "abc@gmail.com"}}})
				User.stub(:find_by_email)
				get "create", {:provider => "facebook" }
				flash[:warning].should == "No one has authorized your email address"
			end
		end	
	end
	describe "failure method" do
		it "should put a failure message in the flash hash" do
				get "failure"
				flash[:warning].should == "You did not allow access for our app."
		end
		it "should redirect to the homepage" do
			get "failure"
			response.should redirect_to(index_path)
		end
	end
	describe "destroy method" do
		it "should reset the session" do
			get :destroy, {}
			session[:user_id].should == nil
		end
		it "should put a log out message in the flash hash" do
			get :destroy, {}
			flash[:notice].should == "You have successfully logged out"
		end
		it "should redirect to the home page" do
			get :destroy, {}
			response.should redirect_to(index_path)
		end
	end
end
