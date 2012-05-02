Feature: Buyers can select the course of the textbook they wish to purchase

  As a buyer
  So the website will show all the relevant books for that course
  I want to select a course that I am taking
  
Background: User has pressed Buy on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given I am on the Buy Course Selection page
  
Scenario: User wants to select the course they will be taking

  Then I should see "Department"
  Then I should see "Number"
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Buy Books page for course number "169" in the "Computer Science" department 
  
