#step definitions for textbookswap

Given /"([a-zA-Z]*)\s?(\d*)" is a course$/ do |course, num|

  Course.create!(:number => num, :department_short => course)

end


