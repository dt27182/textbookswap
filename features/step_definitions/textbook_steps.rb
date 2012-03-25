#step definitions for textbookswap

###Given /"([a-zA-Z]*)\s?(\d*)" is a course$/ do |course, num|

#for deptartment_long entries only!
Given /^the "(.*)" department is offering course number "(.*)"$/ do |dept, num|

  Course.create!(:number => num, :department_long => dept)
end

Given /^the "(.*)" edition of the book "(.*)" exists$/ do |edi, name|

  Book.create!(:title => name, :edition => edi)
end

Given /^the "(.*)" edition of the book "(.*)" is a required book for course number "(.*)" in the "(.*)" department$/ do |edi, name, num, dept|

  course = Course.find_by_number_and_department_long(num, dept)
  book = Book.find_by_title_and_edition(name, edi)
  course.books << book
end
