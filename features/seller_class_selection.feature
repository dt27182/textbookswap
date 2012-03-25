Feature: Sellers can select the class of the textbook they wish to post

  As a seller
  So I can input a book that is relavent to the course
  I want to be able to pick a course
    
Background: User has pressed Sell on the previous page

  Given I am on the Sell Course Selection page
  
Scenario: User wants to select the course corresponding to the book they want to sell

  Then I should see "Select Course"
  Then I should see "Course Search Box"
  When I fill in "Course Search Box" with "CS 169"
  When I press "Search"
  Then I should be on the Sell Required Books page for "CS 169"
