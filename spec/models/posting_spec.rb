require 'spec_helper'

describe Posting do

  describe "sending seller the buyer's info" do
  
    it "should call the Usermailer method" do
      @fake_post = Posting.create!({:seller_email => "abc@gmail.com", :seller_name => "Seller", :price => 30, :location => "South Side", :condition => "New", :comments => "Only used this book before my exams", :reserved => false})
      @fake_post.book_id = '1'
      @fake_post.save!
      @fake_book = Book.create!({:title => "Book", :author => "Professor", :edition => "1", :isbn => "960-425-059-0"})
      @fake_mail = ""
      @fake_mail.stub(:deliver).and_return(true)
      UserMailer.should_receive(:send_seller_buyer_email).with("abc@gmail.com", "xyz@gmail.com", "Only used this book before my exams", "Book").and_return(@fake_mail)
      @fake_post.send_seller_buyer_info("xyz@gmail.com", "Only used this book before my exams")
    end
    
  end
  
  describe "encrypting and decrypting posting_id" do
    
    it "should be inverse functions" do
      (1..10).each do |a|
        a.should == Posting.decrypt(Posting.encrypt(a))
      end
    end
    
  end

end

