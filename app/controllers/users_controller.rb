class UsersController < ApplicationController

  def new
    if session[:user_id].nil?
      flash[:warning] = "YYou do not have the privilege to add a new user."
      redirect_to index_path() and return
    end
    User.create({:email => params[:email]})
    flash[:notice] = "User added"
    redirect_to display_admin_page_path() and return
  end
  
end
