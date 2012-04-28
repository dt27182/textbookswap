Feature: Admin user can add other admins

  As an admin user
  So that I can distribute admin privileges
  I want to be able to add new admin user
  
Background: User has logged in as admin

  Given I am an admin
  Given I am on the admin page
  
Scenario: An admin user adds another user to be one of the admin users of the website

  Then I should see "Admin"
  Then I should see "Add new Admin user"
  When I fill in "New Admin User:" with "new_admin@berkeley.edu"
  When I press "Add new Admin user"
  Then I should see that the e-mail "new_admin@berkeley.edu" was added to the Admin User list
