Feature: Customers can select whether they intend on buying or selling a book
 
  As a website user
  So that I can buy or sell a book
  I want to be able to choose if I'm a buyer or seller

Background: User is on the home page
  
  Given I am on the home page
  
Scenario: User wants to sell a textbook

  Then I should see "Sell"
  Then I can press the Sell button
  When I press "Sell"
  Then I should be on the Sell Course Selection page

Scenario: User wants to buy a textbook

  Then I should see "Buy"
  Then I can press the Buy button
  When I press "Buy"
  Then I should be on the Buy Course Selection page
