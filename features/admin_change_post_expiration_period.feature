Feature: Admin user can change the time period for expiration

  As an Admin
  So that I can experiment with different post expiration periods
  I should be able to change the time period for the website to expire postings

Background: User has logged in as admin

  Given the expiration time is "20" days
  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email         | seller_name     | book_name                         | book_edition | price | location   | condition      | posted_#_days_ago |
  | david@berkeley.edu   | David Patterson | Engineering Long-Lasting Software | Alpha        | 1337  | South Side | Brand New      | 10                |
  | armando@berkeley.edu | Armando Fox     | Engineering Long-Lasting Software | Alpha        | 150   | North Side | Notes all over | 1                 |
  
  Given I am an admin
  Given I am on the admin page
		
Scenario: Admin changes expiration date and book postings before the expiration date should not be shown

  Then I should see "Admin"
  When I fill in "expiration_date" with "5"
	When I press "Update"
  Then I should be on the home page
  Then I should see "Settings Saved!"
  When I follow "buyer_button"
  Then I should be on the Buy Course Selection page
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Buy Books page for course number "169" in the "Computer Science" department
  Then I should see "Engineering Long-Lasting Software" in "Required"
  When I follow "Engineering Long-Lasting Software"
  Then I should be on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  Then I should not see "1337"
  Then I should not see "david@berkeley.edu"
  Then I should not see "South Side"
  Then I should see "99"
  Then I should see "armando@berkeley.edu"
  Then I should see "North Side"
  
  
  
