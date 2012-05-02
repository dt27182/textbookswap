Feature: Sellers can enter details for a posting on a book they wish to sell

  As a seller, once I have selected which book I am selling
  So that I can differentiate my offer from other offers on the same book
  I want to be able to input details about my offer such as condition and price
  
Background: User has indicated the book they want to sell
  
  Given the expiration time is "20" days
  Given the semester is "spring"
  Given the year is "2012"
  Given the "Computer Science" department is offering course number "169"
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"
  
Scenario: User wants to create a posting for the book they want to sell

  When I fill in "Price" with "99"
  When I select "Brand New" from "Condition of your book:"
  When I fill in "posting_comments" with "Only threw up on it twice"
  When I fill in "posting_seller_email" with "student@berkeley.edu"
  When I fill in "posting_seller_name" with "Fyodor Dostoevsky"
  When I select "South Side" from "posting_location"
  When I press "Post!"
  Then I should be on the home page
  Then I should see "Book posting submitted! We will e-mail you if someone wishes to buy your book!"
  
  When I navigate to the Book Postings page for CS169 for the "10th Edition" edition of the book "Armando Fox Autobiography" from the homepage
  When I follow "99 / Brand New / South Side"
  Then I should be on the Buy Additional Information page for the "10th Edition" edition of the book "Armando Fox Autobiography" posted by "Fyodor Dostoevsky" at "student@berkeley.edu"
  Then I should see the posting information for "Armando Fox Autobiography" made by "Fyodor Dostoevsky"
