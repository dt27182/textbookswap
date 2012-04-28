class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by_email(auth_hash["info"]["email"])
    if user.nil?
      flash[:warning] = "No one has authorized your email address"
      redirect_to index_path() and return
    end
    session[:user_id] = user.id
    redirect_to display_admin_page_path() and return
  end
  
  def failure
    flash[:warning] = "You did not allow access for our app."
    redirect_to index_path() and return
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
  end
    
  
end
