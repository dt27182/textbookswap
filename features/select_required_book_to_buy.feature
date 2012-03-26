Feature: Buyers can select the book they wish to buy for the class they selected

  As a buyer
  So that I can look at the postings for a book I need
  I want to be able to select a book that is officially​ required for a class I have picked
  
Background: User selected Computer Science 169 on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given I am on the Buy Books page for course number "169" in the "Computer Science" department
  
Scenario: User wants to select the required book they wish to buy

  Then I should see "Engineering Long-Lasting Software" in "Required"
  When I follow "Engineering Long-Lasting Software (Alpha)"
  Then I should be on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"


