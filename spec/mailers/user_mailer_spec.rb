require "spec_helper"

describe UserMailer do
  describe "Sending the seller the buyer's info" do
    before(:each) do
      @comments = "This is some user comments"
      @buyer_email = "atkaiser@berkeley.edu"
      @seller_email = "akaiser2@mac.com"
      @book_title = "Software Engineering"
      @mail = UserMailer.send_seller_buyer_email(@seller_email, @buyer_email, @comments, @book_title)
    end

    it "should send to the right person" do
      @mail.to.should == [@seller_email]
    end

    it "should contain the buyer's email" do
      email_regex = /atkaiser@berkeley.edu/
      @mail.encoded.should =~ email_regex
    end

    it "should contain the buyer's comments" do
      comment_regex = /This is some user comments/
      @mail.encoded.should =~ comment_regex
    end

  end
  
  describe "Sending mail to the seller with link to admin page" do
    before(:each) do
      @seller_email = "atkaiser@berkeley.edu"
      @link = "/postings/admin/dslavj3dsl"
      @mail = UserMailer.send_seller_admin_page(@seller_email, @link)
    end
  
    it "should send to the correct person" do
      @mail.to.should == [@seller_email]
    end
    
    it "should contain the link to the posting admin page" do
      link_regex = /\/postings\/admin\/dslavj3dsl/
      @mail.encoded.should =~ link_regex
    end
        
  end
  
end
