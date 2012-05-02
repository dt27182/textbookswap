Feature: Sellers can select the class of the textbook they wish to post

  As a seller
  So I can input a book that is relavent to the course
  I want to be able to pick a course
    
Background: User has pressed Sell on the previous page

  Given the semester is "spring"
  Given the year is "2012"
  Given the "Computer Science" department is offering course number "169"
  Given I am on the Sell Course Selection page
  
Scenario: User wants to select the course corresponding to the book they want to sell

  Then I should see "Department"
  Then I should see "Number"
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Sell Books page for course number "169" in the "Computer Science" department 

