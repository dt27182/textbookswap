Feature: Admin user can add other admins

  As an admin user
  So that I can distribute admin privileges
  I want to be able to add new admin user
  
Background: User has logged in as admin

	Given the expiration time is "20" days
  Given the semester is "spring"
  Given the year is "2012"
  Given I am an admin
  Given I am on the admin page
  
Scenario: An admin user adds another user to be one of the admin users of the website

  Then I should see "Logged in as Admin"
  Then I should see "New Admin User (Facebook e-mail):"
  When I fill in "user_email" with "new_admin@berkeley.edu"
  When I press "Add new Admin user"
  Then I should see that the e-mail "new_admin@berkeley.edu" was added to the Admin User list
