class Book < ActiveRecord::Base
  has_many :postings
  has_many :requirements
  has_many :courses, :through => :requirements
  validates :title, :author, :edition, :isbn, :presence => true
  validates :edition, :uniqueness => {:scope => [:title, :author]}
  validates :isbn, :isbn_format => true
  
  def self.get_books()
    agent = Mechanize.new
    semester = Misc.find_by_key("semester").value
    year = Misc.find_by_key("year").value
    set_semester_and_year(agent, semester, year)
    Course.where(:term => semester, :year => year.to_i).each do |course|
      if course.find_required_and_unrequired_books[0].empty?
        sleep 1
        books_page = agent.get("http://ninjacourses.com/explore/1/course/#{course.department_short}/#{course.number}/#books")
        get_books_from_page(books_page, course)
      end
    end
  end
  
  def self.set_semester_and_year(agent, semester, year)
    login_page = agent.get("http://ninjacourses.com/profiles/")
    login_form = login_page.form
    login_form.username = "textbookswap@berkeley.edu"
    login_form.password = "goodbooks"
    profile_page = agent.submit(login_form)
    options = profile_page.parser.xpath('/html/body/div/div/form/div').to_html
    if options =~ /(.{3})\">#{semester.camelize} #{year.to_s}<\/option/
      value = $1.gsub(/^[^\d]+/, "")
      profile_form = profile_page.form
      profile_form.current_semester = value
      agent.submit(profile_form)
    end
  end
    

  def self.get_books_from_page(books_page, course)
    section = course.section
    lectures = books_page.parser.xpath("/html/body/div/div/div/div/div[@id='tab-books']//h4")
    j = 1
    lectures.each do |lecture|
      if lecture.content =~ /#{section}/
        titles = books_page.parser.xpath("//div[@id='tab-books']//table[#{j}]//h5")
        other_info = books_page.parser.xpath("//div[@id='tab-books']//table[#{j}]//li")
        i = 0
        titles.each do |title|
          book = {}
          book[:title] = title.content
          book[:author] = other_info[i].content
          if other_info[i+1].content =~ /ISBN-13: (\d{13})\s/
            book[:isbn] = $1
          end
          if other_info[i+1].content =~ /Edition: (.*)\s/
            book[:edition] = $1
          else
            book[:edition] = "1st"
          end
          if not other_info[i+2].nil?
            if other_info[i+2].content =~ /\$(\d+)\.\d+/
              book[:suggested_price] = $1
              increase_by = 3
            else
              increase_by = 2
            end
          else
            increase_by = 2
          end
          b = Book.new(book)
          if b.save
            Requirement.create(:course_id => course.id, :book_id => b.id, :is_required => true)
          end
          i += increase_by
        end
      end
      j += 1
    end
  end
  
end
