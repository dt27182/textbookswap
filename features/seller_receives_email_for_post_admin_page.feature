Feature: Seller gets link to an admin page for his posting
	
		As a seller, once I finish entering in my posting 
		So that I can edit my posting later
		I want to get an email with a link to an admin page to that posting
		
Background: User has indicated the book they want to sell
	
	Given the "Computer Science" department is offering course number "169"
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"
  
Scenario: User sucessfuly made his posting
  When I fill in "Price" with "99"
  When I select "Brand New" from "Condition of your book:"
  When I fill in "posting_comments" with "Only threw up on it twice"
  When I fill in "posting_seller_email" with "student@berkeley.edu"
  When I fill in "posting_seller_name" with "Fyodor Dostoevsky"
  When I select "South Side" from "posting_location"
  When I press "Post!"
  Then "student@berkeley.edu" should receive an email with subject "Important information about your posting on Textbook Swap"
  
