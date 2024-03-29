Feature: Postings expire and are removed after a certain time period which is set by an admin

  As an buyer,
  So that I can look at relevant offers more efficiently,
  I don't want to see expired posts.
  
Background: Admin has already set an expiration time and old posts exist on the site.

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email                   | seller_name     | book_name                         | book_edition | price | location    | condition | posted_#_days_ago |
  | testDoesNotExist@berkeley.edu  | David Patterson | Engineering Long-Lasting Software | Alpha        | 1337  | Flea Market | Poor      | 1000              |
  | testDoesNotExist2@berkeley.edu | Armando Fox     | Engineering Long-Lasting Software | Alpha        | 99    | Morgan Hall | Excellent | 1                 |
  
  Given the expiration time is "100" days
  Given I am on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  
Scenario: Old Book Posting should not be shown
  
  Then I should not see "1337"
  Then I should not see "Poor"
  Then I should not see "Flea Market"

Scenario: New Book Posting should be shown

  Then I should see "99"
  Then I should see "Excellent"
  Then I should see "Morgan Hall"
