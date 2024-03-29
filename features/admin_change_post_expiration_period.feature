Feature: Admin user can change the time period for expiration

  As an Admin
  So that I can experiment with different post expiration periods
  I should be able to change the time period for the website to expire postings

Background: User has logged in as admin

  Given the expiration time is "20" days
  Given the semester is "spring"
  Given the year is "2012"
  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email         | seller_name     | book_name                         | book_edition | price | location   | condition      | posted_#_days_ago |
  | david@berkeley.edu   | David Patterson | Engineering Long-Lasting Software | Alpha        | 1337  | South Side | Brand New      | 10                |
  
  Given I am an admin
  Given I am on the admin page
		
Scenario: Admin changes expiration date and book postings before the expiration date should not be shown
  When I fill in "expiration_time" with "5"
	When I press "Update"
  Then I should be on the admin page
  Then I should see "Settings Saved!"
  Given I am on the home page
  When I navigate to the Book Postings page for CS169 for the "Alpha" edition of the book "Engineering Long-Lasting Software" from the homepage
  Then I should not see "1337"
  Then I should not see "david@berkeley.edu"
  Then I should not see "South Side"

  
  
  
