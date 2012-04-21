Feature: Seller can select or post new unlisted book that they wish to sell

  As a seller, once I have selected a class
  So that I can sell a book that is relevant to the class but is not officially​ listed
  I want to be able to select or post an unlisted book

Background: User selected Computer Science 169 on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Sell Books page for course number "169" in the "Computer Science" department

Scenario: User wants to sell an unrequired book that has been previously posted by a user
  
  Then I should see "Armando Fox Autobiography" in "Unrequired"
  When I follow "Armando Fox Autobiography"
  Then I should be on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"

Scenario: User wants to sell an unrequired book that has never been previously posted by a user

  When I press "Enter Unlisted Book"
  Then I should be on the Textbook Information page for course number "169" in the "Computer Science" department
