Feature: Seller can republish, update, and delete his posting

  As a Seller
  So that I can put my offer back, update settings, or delete the offer on the site
  I should be able to republish, update, and delete my posting on the posting admin page

Background: Seller follows the link to the seller admin page he/she got in the email

  Given the expiration time is "20" days
  Given the semester is "spring"
  Given the year is "2012"
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
  Then I should see the posting information for "Engineering Long-Lasting Software" made by "Fake Person"
  Then I should see "Your updated post has been republished!"

Scenario: Seller wants to update the info of the post
  When I fill in "Price in dollars:" with "30"
  When I select "Used it few times" from "Condition of your book:"
  When I fill in "posting_seller_email" with "real_person@berkeley.edu"
  When I fill in "posting_seller_name" with "Real Person"
  When I select "North Side" from "new_post_location"
  When I press "Update and Re-Publish"
  Then I should be on the Buy Additional Information page for the "Alpha" edition of the book "Engineering Long-Lasting Software" posted by "Real Person" at "real_person@berkeley.edu"
  Then I should see the posting information for "Engineering Long-Lasting Software" made by "Real Person"
  Then I should see "Your updated post has been republished!"
  
Scenario: Seller wants to delete the post of the book because he sold the book
  When I press "Delete Post"
  Then I should be on the home page
  Then I should see "Post Successfully Deleted!"
  When I navigate to the Book Postings page for CS169 for the "Alpha" edition of the book "Engineering Long-Lasting Software" from the homepage
  Then I should not see "100000000"
  Then I should not see "fake_person@berkeley.edu"
  Then I should not see "South Side"

