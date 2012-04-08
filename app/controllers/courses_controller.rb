class CoursesController < ApplicationController
  def show
    temp = Course.select("department_long").uniq
    @departments = []
    temp.each do |dept|
    @departments << dept.department_long unless dept.department_long == ""
    end
    temp = Course.select("number").uniq
    @numbers = []
    temp.each do |num|
      @numbers << num.number unless num.number == ""
    end
    temp = Course.select("section").uniq
    @sections = []
    temp.each do |sec|
      @sections << sec.section unless sec.section == ""
    end
  end

  def input
    get_courses_for(parmas[:term], params[:year].to_i)
    redirect_to '/'
  end

  def find
    course_term = "spring"
    course_year = 2012
    if params[:course].nil?
    	flash[:notice] = "No course was selected"
    	redirect_to show_courses_path(params[:transaction_type]) and return
    end
    course = Course.find(:first, :conditions => { :term => course_term,
                           :year => course_year,
                           :department_long => params[:course][:department],
                           :number => params[:course][:number],
                           :section => params[:course][:section] } )
    if course.nil?
    	flash[:notice] = "No course was selected"
      redirect_to show_courses_path(params[:transaction_type]) and return
    end
    redirect_to show_books_path(params[:transaction_type], course.id)
  end

  def show_books
    course = Course.find_by_id(params[:id])
    @required_books, @unrequired_books = course.find_required_and_unrequired_books
  end
  
  #needs to return json
	def find_course_numbers
	end
	
	#needs to return json
	def find_course_sections
	end
end
