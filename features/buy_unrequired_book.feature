Feature: Buyer can select unlisted book that they wish to buy

  As a buyer, once I have selected a class
  So that I can buy a book that is relevant to the class but is not officially​ listed
  I want to be able to select an unlisted book offered by sellers

Background: User selected Computer Science 169 on the previous page

  Given the expiration time is "20" months
  Given the "Computer Science" department is offering course number "169"
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Buy Books page for course number "169" in the "Computer Science" department
  
Scenario: User wants to select an unrequired book

  Then I should see "Armando Fox Autobiography" in "Unrequired"
  When I follow "Armando Fox Autobiography"
  Then I should be on the Book Postings page for the "10th Edition" edition of the book "Armando Fox Autobiography"
