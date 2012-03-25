Feature: Sellers can select the book they wish to sell for the class they selected

  As a seller
  So that I can input details of my offer to sell a book
  I want to be able to select a book that is officially​ required for a class I have picked
  
Background: User selected Computer Science 169 on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Sell Required Books page for course number "169" in the "Computer Science" department
  
Scenario: User wants to select the required book they wish to sell

  Then I should see "Engineering Long-Lasting Software"
  When I follow "Engineering Long-Lasting Software (Alpha)"
  Then I should be on the Sell Book Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software"

Scenario: User wants to sell a listed unrequired book
  
  Then I should see "Armando Fox Autobiography"
  When I follow "Armando Fox Autobiography (10th Edition)"
  Then I should be on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"

Scenario: User wants to sell an unlisted unrequired book
  When I follow "Sell New Unrequired Book"
  Then I should be on the Textbook Information page for course number "169" in the "Computer Science" department
