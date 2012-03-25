Feature: Buyers can select the class of the textbook they wish to purchase

  As a buyer
  So the website will show all the relevant books for that course
  I want to select a class that I am taking
  
Background: User has pressed Buy on the previous page

  Given I am on the Buy Course Selection page
  Given the "Computer Science" department is offering course number "169"
  
Scenario: User wants to select the course they will be taking

  Then I should see "Select Course"
  Then I should see "course_department"
  Then I should see "course_number"
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Search"
  Then I should be on the Buy Required Books page for course number "169" in the "Computer Science" department 
