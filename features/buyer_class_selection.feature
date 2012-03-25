Feature: Buyers can select the class of the textbook they wish to purchase

  As a buyer
  So the website will show all the relevant books for that course
  I want to select a class that I am taking
  
Background: User has pressed Buy on the previous page

  Given I am on the Buy Course Selection page
  
Scenario: User wants to select the course they will be taking

  Then I should see "Select Course"
  Then I should see "Course Search Box"
  When I fill in "Course Search Box" with "CS 169"
  When I press "Search"
  Then I should be on the Buy Required Books page for "CS 169"
