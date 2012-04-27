Feature: Admin user can change the current semester served by the website
	
	As an Admin,
	So that I can update the site when a new semester starts
	I want to be able to change the current semester
	
Background: User has logged in as admin

	Given the current semester is "spring" "2012"
	Given I am on the admin page
	When I select "Fall" from "current_semester"
	When I fill in "current_year" with "2013"
	When I press "Update"
	Then I should be on the admin page
