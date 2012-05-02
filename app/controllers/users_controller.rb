class UsersController < ApplicationController

  def new
    if session[:user_id].nil?
      flash[:warning] = "You do not have the privilege to add a new user."
      redirect_to index_path() and return
    end
    new_user = User.create({:email => params[:user][:email]})
    if new_user.id.nil?
    	flash[:warning] = "This Admin e-mail already exists"
    else
	    flash[:notice] = "User added"
  	end
  	redirect_to display_admin_page_path() and return
  end
  
  def fake_login
  	if Rails.env.test?
  		session[:user_id] = User.create!.id
  	end
  	redirect_to index_path
  end
end
