class CoursesController < ApplicationController
  def show
    flash[:notice] = nil
    temp = Course.select("department_long")
    @departments = []
    temp.each do |dept|
    @departments << dept.department_long unless dept.department_long == "" or @departments.include?(dept.department_long)
    end
    temp = Course.select("number")
    @numbers = []
    temp.each do |num|
      @numbers << num.number unless num.number == "" or @numbers.include?(num.number)
    end
    temp = Course.select("section")
    @sections = []
    temp.each do |sec|
      @sections << sec.section unless sec.section == "" or @sections.include?(sec.section)
    end
    @departments.sort!
    @numbers.sort_by! do |s|
      [1, s.gsub(/[a-zA-Z]/, "").to_i]
    end
    @sections.sort!
  end

  def input
    Course.get_courses_for(params[:term], params[:year].to_i)
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
    @course = Course.find_by_id(params[:id])
    @transaction_type = params[:transaction_type]

    @required_books, @unrequired_books = @course.find_required_and_unrequired_books

    if @required_books.empty?
      flash[:notice] = "This class has no required books"
    end

  end

  #needs to return json
	def find_course_numbers
		department = params[:department]
		courses = Course.find_all_by_department_long(department)
		@numbers = []
		courses.each do |course|
			@numbers << course.number
		end
		respond_to do |format|
			format.json { render :json => @numbers }
		end
	end
	
	#needs to return json
	def find_course_sections
	end
end
