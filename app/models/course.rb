class Course < ActiveRecord::Base
  has_many :requirements
  has_many :books, :through => :requirements
  #Validates the same course isn't added twice
  validates :term, :uniqueness => { :scope => [ :number, :name, :department_short, :department_long, :teacher, :section, :year ] }

  def get_courses_for(term, year)
    term_acronym = get_term_acronym(term)
    agent = Mechanize.new
    courses_page = agent.get('http://osoc.berkeley.edu/OSOC/osoc?p_term=' + term_acronym + '&p_list_all=Y')
    list_of_course_objects = courses_page.root.css('body td td label')
    department_long_couter = 3
    list_of_course_objects.each_slice(3) do |course_tuple|
      if course[:department_short] != course_tuple[0].content
        department_long_counter += 1
      end
      course = {}
      course[:department_short] = course_tuple[0].content
      course[:number] = course_tuple[1].content[3..-1]
      course[:name] = course_tuple[2].content
      course[:term] = term
      course[:year] = year
      course[:department_long] = courses_page.root.css("body td td font")[department_long_counter].content
      get_teacher(courses_page, course).each do |teacher|
        #add section_info
        course[:teacher] = teacher
        c = Course.new(course)
        c.save
      end
    end
  end

  def get_term_acronym(term)
    term_acronyms = { "spring" => "SP", "fall" => "FL", "summer" => "SU" }
    return term_acronyms[term]
  end

  def get_teacher(course_page, course)
    agent = Mechanize.new
    form = course_page.form
    form.p_dept = course[:department_short]
    form.p_course = course[:number]
    form.p_title = course[:name]
    detailed_course_page = agent.submit(form)
    page_elements = detailed_course_page.root.css('body table tr td')
    page_elements.each_conts(2) do |two_elements|
      if two_elements[0].content =~ /Instructor/
        return two_elements[1].content
      end
    end
    return "Bob"
  end

  #returns the required books and unrequired books of the course with :id == id as an array of 2 arrays eg [[list of required books][list of unrequired books]]
  def find_required_and_unrequired_books(id)

  end
end
