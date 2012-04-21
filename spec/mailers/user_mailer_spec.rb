require "spec_helper"

describe UserMailer do
  describe "Sending the seller the buyer's info" do
    before(:each) do
      @comments = "This is some user comments"
      @buyer_email = "atkaiser@berkeley.edu"
      @seller_email = "akaiser2@mac.com"
      @mail = UserMailer.send_seller_buyer_email(@seller_email, @buyer_email, @comments)
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
end
