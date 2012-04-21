Feature: Sellers can select the book they wish to sell for the class they selected

  As a seller
  So that I can input details of my offer to sell a book
  I want to be able to select a book that is officially​ required for a class I have picked
  
Background: User selected Computer Science 169 on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given I am on the Sell Books page for course number "169" in the "Computer Science" department
  
Scenario: User wants to select the required book they wish to sell

  Then I should see "Engineering Long-Lasting Software" in "Required"
  When I follow "Engineering Long-Lasting Software"
  Then I should be on the Sell Book Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software"


