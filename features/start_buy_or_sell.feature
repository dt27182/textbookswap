Feature: Customers can select whether they intend on buying or selling a book
 
  As a website user
  So that I can buy or sell a book
  I want to be able to start the buy or sell process on the home page.

Background: User is on the home page
  
  Given I am on the home page
  
Scenario: User wants to sell a textbook

  Then I should see "Sell"
  When I follow "seller_button"
  Then I should be on the Sell Course Selection page

Scenario: User wants to buy a textbook

  Then I should see "Buy"
  When I follow "buyer_button"
  Then I should be on the Buy Course Selection page
