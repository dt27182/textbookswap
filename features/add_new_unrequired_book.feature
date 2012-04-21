Feature: Sellers can enter information on an unrequired book that has never been previously posted by a user

  As a Seller, once I have a chosen a class
  So that I can sell textbooks that are related to the class but is not currently listed on the site.
  I want to be able to add a new unrequired book
  
Background: User clicked "Enter Unlisted Book" on the Sell Books Page
  
  Given the "Computer Science" department is offering course number "169"
  Given I am on the Textbook Information page for course number "169" in the "Computer Science" department
  
Scenario: User wants to post information on a new unrequired book

  When I fill in "Title" with "Armando Fox Autobiography"
  When I fill in "Author" with "David Patterson"
  When I fill in "Edition" with "10th Edition"
  When I fill in "ISBN" with "1-84356-028-3"
  When I press "Next"
  Then I should be on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"
  
Scenario: User enters information incorrectly
  When I fill in "Title" with ""
  When I fill in "Author" with "David Patterson"
  When I fill in "Edition" with "10th Edition"
  When I fill in "ISBN" with "1-84356-028-3"
  When I press "Next"
  Then I should be on the Textbook Information page for course number "169" in the "Computer Science" department
  Then I should see "Enter in details about your book"
