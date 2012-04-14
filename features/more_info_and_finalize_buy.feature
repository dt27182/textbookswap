Feature: Buyers can view additional information on the book they want to buy and contact the sellers

  As a buyer, once I choose an offer for the book I want
  So I can see more information and finalize my purchase
  I should be able to view more information and enter a message to be sent to the seller by the website
 
Background: Buyer has clicked the posting they are interested in on the previous page

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given somebody named "David Patterson" with the e-mail "david@patterson.gov" posted the "Alpha" edition of the book "Engineering Long-Lasting Software" for "99" in "Excellent" condition at "Black Market"
  Given I am on the Buy Additional Information page for the "99" dollar "Excellent" quality "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "David Patterson" at "david@patterson.gov" at "Black Market"
  
Scenario: User wants to purchase the book offered by the posting

  When I fill in "Name" with "Not A Murderer"
  When I fill in "Email" with "recently@escaped.gov"
  When I fill in "Message" with "Hey David, I want to buy this book of yours. Can we meet in a dark back alley downtown?"
  When I press "Finalize Purchase"
  Then I should be on the home page
  Then I should see "Buy Request Submitted! We Have Emailed The Seller Your Message & Contact Information!"
