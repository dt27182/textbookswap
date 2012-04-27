Feature: Posting is hidden on the site when someone buys it

	As a buyer, once I send a message through the website to the seller to buy his book
	So that no one else buys my book
	I want that posting to be no longer visible on the website 
	
Background:
	Given the expiration time is "20" days
	Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given somebody named "David Patterson" with the e-mail "testDoesNotExist@berkeley.edu" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "99" in "Excellent" condition at "Black Market"
  Given I am on the Buy Additional Information page for the "99" dollar "Excellent" quality "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "David Patterson" at "testDoesNotExist@berkeley.edu" at "Black Market"
  
Scenario: User successfully buys a posting
	When I fill in "email_buyer_email" with "recentlyescaped@berkeley.edu"
  When I fill in "email_body" with "Hey David, I want to buy this book of yours. Can we meet in a dark back alley downtown?"
  Then I press "Send"
  Given I am on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  Then I should not see "99"
  Then I should not see "Excellent"
  Then I should not see "Black Market"
  
  
