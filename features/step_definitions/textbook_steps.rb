#step definitions for textbookswap

###Given /"([a-zA-Z]*)\s?(\d*)" is a course$/ do |course, num|

#for deptartment_long entries only!
Given /^the "(.*)" department is offering course number "(.*)"$/ do |dept, num|

  Course.create!(:number => num, :department_long => dept, :section => "001", :term => "spring", :year => 2012, :department_short => "TEST", :teacher => "Patterson", :name => "A test course")
end

Given /^the "(.*)" edition of the book "(.*)" exists$/ do |edi, name|

  Book.create!(:title => name, :edition => edi, :isbn => "0812500482", :author => "Armando")
end

Given /^the "(.*)" edition of the book "(.*)" is a required book for course number "(.*)" in the "(.*)" department$/ do |edi, name, num, dept|

  course = Course.find_by_number_and_department_long(num, dept)
  book = Book.find_by_title_and_edition(name, edi)
  req = Requirement.create!(:course_id => course.id, :book_id => book.id, :is_required => true)
  course.requirements << req
  book.requirements << req
  course.books << book
end

Given /^the "(.*)" edition of the book "(.*)" is an unrequired book for course number "(.*)" in the "(.*)" department$/ do |edi, name, num, dept|

  course = Course.find_by_number_and_department_long(num, dept)
  book = Book.find_by_title_and_edition(name, edi)
  req = Requirement.create!(:course_id => course.id, :book_id => book.id, :is_required => false)
  req.save!
  course.requirements << req
  book.requirements << req
  course.books << book
end

Then /^(?:|I )should see "([^"]*)" in "([^"]*)"$/ do |regexp, parent|
  with_scope(parent) do
    regexp = Regexp.new(regexp)

    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Given /^the expiration time is "(.*)" days$/ do |numStr|
  m = Misc.create!(:key => "expiration_time", :value => numStr)
  m.save!
end

Given /the following postings exist/ do |postings_table|
  postings_table.hashes.each do |posting|
    # each returned element will be a hash whose key is the table header. I.E. "seller_name" "price" & "release_date"
    Posting.create!(:seller_email => posting["seller_email"], :seller_name => posting["seller_name"], :price => posting["price"], :location => posting["location"], :condition => posting["condition"], :created_at => Time.now - Integer(posting["posted_#_days_ago"]).days, :book_id => Book.find_by_title_and_edition(posting["book_name"], posting["book_edition"]).id)
  end
end

Given /^somebody contacted the e-mail "(.*)" for "(.*)" edition of the book "(.*)"$/ do |email, edition, bookTitle|
  book = Book.find_by_title_and_edition(bookTitle, edition)
  posting = Posting.find_by_seller_email_and_book_id(email, book.id)
  posting.reserved = true
  posting.save!
end

Given /^I am an admin$/ do
	cookies[:user_id] = User.create!.id
end

