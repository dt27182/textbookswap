Feature: Sellers can select the class of the textbook they wish to post

  As a seller
  So I can input a book that is relavent to the course
  I want to be able to pick a course
    
Background: User has pressed Sell on the previous page

  Given I am on the Sell Course Selection page
  Given the "Computer Science" department is offering course number "169"
  
Scenario: User wants to select the course corresponding to the book they want to sell

  Then I should see "Select Course"
  Then I should see "course_department"
  Then I should see "course_number"
  When I select "Computer Science" from "course_department"
  When I fill in "course_number" with "169"
  When I press "search"
  Then I should be on the Sell Required Books page for course number "169" in the "Computer Science" department 
