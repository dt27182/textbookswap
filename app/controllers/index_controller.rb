class IndexController < ApplicationController

  def index
    render :layout => 'home'
    flash[:notice] = nil
  end

end
