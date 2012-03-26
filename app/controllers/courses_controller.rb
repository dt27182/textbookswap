class CoursesController < ApplicationController
  def show
    @temp = Course.select("department_long").uniq
    @departments = []
    @temp.each do |dept|
      @departments << dept.department_long unless dept.department_long == ""
    end
    @temp = Course.select("number").uniq
    @numbers = []
    @temp.each do |num|
      @numbers << num.number unless num.number == ""
    end
  end

  def input
    get_courses_for(parmas[:term], params[:year].to_i)
    redirect_to '/'
  end
  
  def show_books
  end
  
  def find
  end
end
