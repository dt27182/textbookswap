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
      
    when /^the Sell Required Books page for course number "(.*)" in the "(.*)" department$/
      course = Course.find_by_number_and_department_long($1, $2)
      return show_books_path("sell", course.id)
    
    when /^the Buy Required Books page for course number "(.*)" in the "(.*)" department$/
      course = Course.find_by_number_and_department_long($1, $2)
      return show_books_path("buy", course.id)
      

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
