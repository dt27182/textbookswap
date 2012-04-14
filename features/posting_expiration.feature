Feature: Postings expire and are removed after a certain time period which is set by an admin

  As an admin,
  So that the website remains free of clutter and outdated posts,
  I want to see old posts be removed.
  
Background: Admin has already set an expiration time and old posts exist on the site.

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is an unrequired for course number "169" in the "Computer Science" department
  Given somebody named "David Patterson" with the e-mail "david@patterson.edu" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "15" in "Poor" condition at "Flea Market" around "30" months ago
  Given somebody named "Armando Fox" with the e-mail "armando@fox.edu" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "99" in "Excellent" condition at "Morgan Hall" around "10" months ago
  Given the expiration time is "20" months
  Given I am on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  
Scenario: Old Book Posting should not be shown


Scenario: New Book Posting should be shown
