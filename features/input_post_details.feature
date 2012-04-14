Feature: Sellers can enter details for a posting on a book they wish to sell

  As a seller, once I have selected which book I am selling
  So that I can differentiate my offer from other offers on the same book
  I want to be able to input details about my offer such as condition and price
  
Background: User has indicated the book they want to sell
  
  Given the "Computer Science" department is offering course number "169"
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" exists
  Given the "10th Edition" edition of the book "Armando Fox Autobiography" is an unrequired book for course number "169" in the "Computer Science" department
  Given I am on the Sell Book Information page for the "10th Edition" edition of the book "Armando Fox Autobiography"
  
Scenario: User wants to create a posting for the book they want to sell

  When I fill in "Price" with "99"
  When I select "Excellent" from "Condition"
  When I fill in "Comments" with "Only threw up on it twice"
  When I fill in "Email" with "student@failing169.edu"
  When I fill in "Name" with "Fyodor Dostoevsky"
  When I fill in "Location" with "Soviet Russia"
  When I press "Finalize Post"
  Then I should be on the home page
  Then I should see "Book Posting Submitted! We Will E-Mail You If Someone Wishes To Buy Your Book!"
  
  When I press "buyer_button"
  Then I should be on the Buy Course Selection page
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Buy Books page for course number "169" in the "Computer Science" department
  Then I should see "Armando Fox Autobiography" in "Unrequired"
  When I follow "Armando Fox Autobiography (10th Edition)"
  Then I should be on the Book Postings page for the "10th Edition" edition of the book "Armando Fox Autobiography"
  Then I should see "99"
  Then I should see "Excellent"
  Then I should see "Soviet Russia"
  When I follow "99 / Excellent / Soviet Russia"
  Then I should be on the Buy Additional Information page for the "99" dollar "Excellent" quality "10th Edition" edition of the book "Armando Fox Autobiography" posted by "Fyodor Dostoevsky" at "student@failing169.edu" at "Soviet Russia"
  Then I should see "Only threw up on it twice"
  Then I should see "student@failing169.edu"
  Then I should see "Fyodor Dostoevsky"
