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
    post = Posting.create!(:seller_email => posting["seller_email"], :seller_name => posting["seller_name"], :price => posting["price"], :location => posting["location"], :condition => posting["condition"])
    post.book_id = Book.find_by_title_and_edition(posting["book_name"], posting["book_edition"]).id
    post.updated_at = Time.now - Integer(posting["posted_#_days_ago"]).days
    post.save!
  end
end

Given /^somebody contacted the e-mail "(.*)" for "(.*)" edition of the book "(.*)"$/ do |email, edition, bookTitle|
  book = Book.find_by_title_and_edition(bookTitle, edition)
  posting = Posting.find_by_seller_email_and_book_id(email, book.id)
  posting.reserved = true
  posting.save!
end

Given /^I am an admin$/ do
	visit path_to("fake login")
end

Then /^I should see that the e-mail "(.*)" was added to the Admin User list$/ do |email|
  admin = User.find_by_email(email)
  bool = admin.nil?
  assert(!bool)
end 

Given /^the semester is "(.*)"$/ do |semester|
	Misc.create!(:key => "semester", :value => semester)
end

Given /^the year is "(.*)"$/ do |year|
	Misc.create!(:key => "year", :value => year)
end

Then /^I should see the posting information for "(.*)" made by "(.*)"$/ do |bookTitle, sellerName|
  book = Book.find_by_title(bookTitle)
  posting = Posting.find_by_seller_name_and_book_id(sellerName, book.id)
  step %{I should see "#{posting.seller_name}"}
  step %{I should see "#{posting.seller_email}"}
  step %{I should see "#{posting.price}"}
  step %{I should see "#{posting.condition}"}
  step %{I should see "#{posting.location}"}
  step %{I should see "#{posting.comments}"}
end

When /^I navigate to the Book Postings page for CS169 for the "(.*)" edition of the book "(.*)" from the homepage$/ do |bookEdi, bookTitle|
  book = Book.find_by_title_and_edition(bookTitle, bookEdi)
  step %{I follow "buyer_button"}
  step %{I should be on the Buy Course Selection page}
  step %{I select "Computer Science" from "course_department"}
  step %{I select "169" from "course_number"}
  step %{I press "Go choose a book"}
  step %{I should be on the Buy Books page for course number "169" in the "Computer Science" department}
  step %{I follow "#{book.title}"}
  step %{I should be on the Book Postings page for the "#{bookEdi}" edition of the book "#{bookTitle}"}
end

