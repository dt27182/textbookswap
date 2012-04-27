Feature: Buyers can view details and select a posting for the book they wish to buy

  As a buyer, once I have selected which book I am buying
  So that I can pick the offer I want
  I want to be able to view a listing of all the offers for that book

Background: 

  Given the expiration time is "20" days
  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email                   | seller_name     | book_name                         | book_edition | price | location   | condition      | posted_#_days_ago |
  | testDoesNotExist@berkeley.edu  | David Patterson | Engineering Long-Lasting Software | Alpha        | 99    | South Side | Brand New      | 1                 |
  | testDoesNotExist2@berkeley.edu | Armando Fox     | Engineering Long-Lasting Software | Alpha        | 150   | North Side | Notes all over | 1                 |

  Given I am on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"


Scenario: 

  Then I should see "99"
  Then I should see "Brand New"
  Then I should see "South Side"
  Then I should see "150"
  Then I should see "Notes all over"
  Then I should see "North Side"
  When I follow "99 / Brand New / South Side"
  Then I should be on the Buy Additional Information page for the "99" dollar "Brand New" quality "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "David Patterson" at "testDoesNotExist@berkeley.edu" at "South Side"
