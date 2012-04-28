class MiscController < ApplicationController

  def display
    if session[:user_id].nil?
      redirect_to "/auth/facebook" and return
    end
    @semester = Misc.find_by_key("semester").value
    @year = Misc.find_by_key("year").value
    @expiration_time = Misc.find_by_key("expiration_time").value
  end

  def commit_edit
  end
  
end
