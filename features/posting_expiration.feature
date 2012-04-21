Feature: Postings expire and are removed after a certain time period which is set by an admin

  As an buyer,
  So that I can look at relevant offers more efficiently,
  I don't want to see expired posts.
  
Background: Admin has already set an expiration time and old posts exist on the site.

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given somebody named "David Patterson" with the e-mail "testDoesNotExist@berkeley.edu" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "15" in "Poor" condition at "Flea Market" around "30" months ago
  Given somebody named "Armando Fox" with the e-mail "testDoesNotExist2@berkeley.edu" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "99" in "Excellent" condition at "Morgan Hall" around "10" months ago
  Given the expiration time is "20" months
  Given I am on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  
Scenario: Old Book Posting should not be shown
  
  Then I should not see "15"
  Then I should not see "Poor"
  Then I should not see "Flea Market"

Scenario: New Book Posting should be shown

  Then I should see "99"
  Then I should see "Excellent"
  Then I should see "Morgan Hall"
