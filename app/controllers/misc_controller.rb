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
    if session[:user_id].nil?
      flash[:warning] = "You do not have privileges to update these values."
      redirect_to index_path() and return
    end
    if params[:misc][:expiration_time] =~ /^\d+$/
      expiration = Misc.find_by_key("expiration_time")
      expiration.value = params[:misc][:expiration_time].to_s
      expiration.save
    end
    new_semester = params[:misc][:semester]
    new_year = params[:misc][:year]
    old_semester = Misc.find_by_key("semester").value
    old_year = Misc.find_by_key("year").value
    if new_semester != old_semester or new_year != old_year
      if new_semester != old_semester
        misc = Misc.find_by_key("semester")
        misc.value = new_semester
        misc.save
      end
      if new_year != old_year and new_year.to_i > 2011
        misc = Misc.find_by_year("year")
        misc.value = new_year.to_s
        misc.save
      end
      Course.get_courses_for(Misc.find_by_key("semester").value, Misc.find_by_key("year").value)
    end
    flash[:notice] = "Settings Saved!"
    redirect_to display_admin_page_path()
  end
  
end
