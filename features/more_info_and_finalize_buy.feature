Feature: Buyers can view additional information on the book they want to buy and contact the sellers

  As a buyer, once I choose an offer for the book I want
  So I can see more information and finalize my purchase
  I should be able to view more information and enter a message to be sent to the seller by the website
 
Background: Buyer has clicked the posting they are interested in on the previous page

  Given the expiration time is "20" days
  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email                  | seller_name     | book_name                         | book_edition | price | location     | condition      | posted_#_days_ago |
  | testDoesNotExist@berkeley.edu | David Patterson | Engineering Long-Lasting Software | Alpha        | 99    | Black Market | Excellent      | 1                 |
  
  Given I am on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "David Patterson" at "testDoesNotExist@berkeley.edu"
  
Scenario: User wants to purchase the book offered by the posting

  When I fill in "email_buyer_email" with "recentlyescaped@berkeley.edu"
  When I fill in "email_body" with "Hey David, I want to buy this book of yours. Can we meet in a dark back alley downtown?"
  When I press "Send"
  Then I should be on the home page
  Then I should see "Buy request submitted! We have emailed the seller your message & contact information!"
  
Scenario: User fails to fill out forms properly

  When I fill in "email_buyer_email" with ""
  When I fill in "email_body" with "I GIVE NOBODY MY EMAIL"
  When I press "Send"
  Then I should be on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "David Patterson" at "testDoesNotExist@berkeley.edu"
  Then I should see "Please fill in the required fields"
