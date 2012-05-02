# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /^the Sell Course Selection page$/
      return show_courses_path("sell")

    when /^the Buy Course Selection page$/
      return show_courses_path("buy")

    when /^the Sell Books page for course number "(.*)" in the "(.*)" department$/
      course = Course.find_by_number_and_department_long($1, $2)
      return show_books_path("sell", course.id)

    when /^the Buy Books page for course number "(.*)" in the "(.*)" department$/
      course = Course.find_by_number_and_department_long($1, $2)
      return show_books_path("buy", course.id)

    when /^the Book Postings page for the "(.*)" edition of the book "(.*)"$/
      book = Book.find_by_title_and_edition($2, $1)
      return show_postings_path(book.id)

    when /^the Sell Book Information page for the "(.*)" edition of the book "(.*)"$/
      book = Book.find_by_title_and_edition($2, $1)
      return display_new_posting_path(book.id)

    when /^the Textbook Information page for course number "(.*)" in the "(.*)" department$/
      course =  Course.find_by_number_and_department_long($1, $2)
      return display_new_book_path(course.id)
      
    when /^the Buy Additional Information page for the "(.*)" edition of the book "(.*)" posted by "(.*)" at "(.*)"$/
      bookEdi = $1
      bookTitle = $2
      name = $3
      email = $4
      book = Book.find_by_title_and_edition(bookTitle, bookEdi)
      posting = Posting.find_by_seller_email_and_seller_name_and_book_id(email, name, book.id)
      return show_posting_path(posting.id)
      
 		when /^fake login$/
 			return fake_login_path
 			
		when /^the admin page$/
			return display_admin_page_path
			
		when /^the seller admin page for the "(.*)" edition of the book "(.*)" posted by "(.*)" at "(.*)"$/
      bookEdi = $1
      bookTitle = $2
      name = $3
      email = $4
      book = Book.find_by_title_and_edition(bookTitle, bookEdi)
      posting = Posting.find_by_seller_email_and_seller_name_and_book_id(email, name, book.id)
			return display_admin_posting_path(Posting.encrypt(posting.id))
		
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
