Feature: Admin user can delete book postings

  As an Admin, 
  So that  I can remove inappropriate content from the site
  I should be able to delete postings
  
Background: User has logged in as admin

  Given the expiration time is "20" days
  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email             | seller_name | book_name                         | book_edition | price     | location   | condition | posted_#_days_ago |
  | fake_person@berkeley.edu | Fake Person | Engineering Long-Lasting Software | Alpha        | 100000000 | South Side | Brand New | 1                 |
  
  Given I am on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "Fake Person" at "fake_person@berkeley.edu"
  Given I am an admin
  
Scenario: Admin wants to delete this post
  Then I should see "Admin"
  Then I should see "Delete this Post"
  When I press "Delete this Post"
  Then I should be on the home page
  Then I should see "Post Successfully Deleted!"
  When I follow "buyer_button"
  Then I should be on the Buy Course Selection page
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Buy Books page for course number "169" in the "Computer Science" department
  Then I should see "Engineering Long-Lasting Software" in "Required"
  When I follow "Engineering Long-Lasting Software"
  Then I should be on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  Then I should not see "100000000"
  Then I should not see "fake_person@berkeley.edu"
  Then I should not see "South Side"
  
  
  
  