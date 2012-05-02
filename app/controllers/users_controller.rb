class UsersController < ApplicationController

  def new
    if session[:user_id].nil?
      flash[:warning] = "You do not have the privilege to add a new user."
      redirect_to index_path() and return
    end
    User.create({:email => params[:user][:email]})
    flash[:notice] = "User added"
    redirect_to display_admin_page_path() and return
  end
  
  def fake_login
  	if Rails.env.test?
  		session[:user_id] = User.create!.id
  	end
  	redirect_to index_path
  end
end
