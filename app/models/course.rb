class Course < ActiveRecord::Base
  has_many :requirements
  has_many :books, :through => :requirements
  #Validates the same course isn't added twice
  validates :term, :uniqueness => { :scope => [ :number, :name, :department_short, :department_long, :teacher, :section, :year ]}
  validates :number, :name, :department_short, :department_long, :teacher, :section, :year, :term, :presence => true

  def self.get_courses_for(term, year)
    term_acronym = get_term_acronym(term)
    agent = Mechanize.new
    courses_page = agent.get('http://osoc.berkeley.edu/OSOC/osoc?p_term=' + term_acronym + '&p_list_all=Y')
    list_of_course_objects = courses_page.root.css('body td td label')
    department_long_counter = 2
    course = {}
    list_of_course_objects.each_slice(3) do |course_tuple|
      if course[:department_short] != course_tuple[0].content
        department_long_counter += 1
      end
      course[:department_short] = course_tuple[0].content
      course[:number] = course_tuple[1].content[3..-1]
      course[:name] = course_tuple[2].content
      course[:term] = term
      course[:year] = year
      course[:department_long] = courses_page.root.css("body td td font")[department_long_counter].content
      get_teacher(courses_page, course).each do |teacher_and_section|
        course[:section] = teacher_and_section[1]
        course[:teacher] = teacher_and_section[0]
        c = Course.new(course)
        c.save
      end
    end
  end

  def self.get_term_acronym(term)
    term_acronyms = { "spring" => "SP", "fall" => "FL", "summer" => "SU" }
    return term_acronyms[term]
  end

#This is a method used to load course info into the database, its not actually a part of the app
=begin Comment
=end
  def self.get_teacher(course_page, course)
    agent = Mechanize.new
    form = course_page.form
    form.p_dept = course[:department_short]
    form.p_course = course[:number]
    form.p_title = course[:name]
    if course[:name][-3..-1] == "..."
      form.p_title = course[:name][0..-4]
    end
    detailed_course_page = agent.submit(form)
    puts detailed_course_page.root
    page_elements = detailed_course_page.root.css('body table tr td')
    page_elements_content = []
    page_elements.each do |elem|
      page_elements_content << elem.content
    end
    teacher_pairs = []
    page_elements_content.each_cons(8) do |elements|
      if elements[0] =~ /Course/
        if elements[1] =~ /LEC|SEM/
          teacher = elements[7]
          section = elements[1].gsub(/\s+/, "")[-6..-4]
          teacher_pairs << [teacher, section]
        end
      end
    end
    return teacher_pairs
  end
#=end

  #returns the required books and unrequired books of the course with :id == id as an array of 2 arrays eg [[list of required books][list of unrequired books]]
  def find_required_and_unrequired_books
    all_books = self.books
    required_books = []
    unrequired_books = []
    all_books.each do |book|
      book_course_req = Requirement.find(:first, :conditions => { :course_id => self.id, :book_id => book.id } )
      if book_course_req.is_required
        required_books << book
      else
        unrequired_books << book
      end
    end
    return [required_books, unrequired_books]
  end
end
