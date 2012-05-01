Feature: Seller can republish, update, and delete his posting

  As a Seller
  So that I can put my offer back, update settings, or delete the offer on the site
  I should be able to republish, update, and delete my posting on the posting admin page

Background: Seller follows the link to the seller admin page he/she got in the email

  Given the "Computer Science" department is offering course number "169"
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" exists
  Given the "Alpha" edition of the book "Engineering Long-Lasting Software" is a required book for course number "169" in the "Computer Science" department
  Given the following postings exist:
  | seller_email             | seller_name | book_name                         | book_edition | price     | location   | condition | posted_#_days_ago |
  | fake_person@berkeley.edu | Fake Person | Engineering Long-Lasting Software | Alpha        | 100000000 | South Side | Brand New | 1                 |
  
  Given somebody contacted the e-mail "fake_person@berkeley.edu" for "Alpha" edition of the book "Engineering Long-Lasting Software"
  Given I am on the seller admin page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "Fake Person" at "fake_person@berkeley.edu"

Scenario: Seller wants to repost the book because he couldn't sell the book
  When I press "Update and Re-Publish"
  Then I should be on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "Fake Person" at "fake_person@berkeley.edu"
  Then I should see "Fake Person"
  Then I should see "fake_person@berkeley.edu"
  Then I should see "100000000"
  Then I should see "Your updated post has been republished!"

Scenario: Seller wants to update the info of the post
  When I fill in "Price in dollars:" with "30"
  When I select "Used it few times" from "Condition of your book:"
  When I fill in "posting_seller_email" with "real_person@berkeley.edu"
  When I fill in "posting_seller_name" with "Real Person"
  When I select "North Side" from "posting_location"
  When I press "Update and Re-Publish"
  Then I should be on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "Real Person" at "real_person@berkeley.edu"
  Then I should see "Real Person"
  Then I should see "real_person@berkeley.edu"
  Then I should see "30"
  Then I should see "Used it few times"
  Then I should see "North Side"
  Then I should see "Your updated post has been republished!"
  
Scenario: Seller wants to delete the post of the book because he sold the book
  When I press "Delete Post"
  Then I should be on the home page
  Then I should see "Posting Deleted!"
  When I follow "buyer_button"
  Then I should be on the Buy Course Selection page
  When I select "Computer Science" from "course_department"
  When I select "169" from "course_number"
  When I press "Go choose a book"
  Then I should be on the Buy Books page for course number "169" in the "Computer Science" department
  Then I should see "Engineering Long-Lasting Software" in "Required"
  When I follow "Engineering Long-Lasting Software"
  Then I should be on the Book Postings page for the "Alpha" edition of the book "Engineering Long-Lasting Software"
  Then I should not see "100000000"
  Then I should not see "fake_person@berkeley.edu"
  Then I should not see "South Side"

