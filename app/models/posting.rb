class Posting < ActiveRecord::Base
	attr_accessible :seller_email, :seller_name, :price, :location, :condition, :comments
  belongs_to :book
  validates :seller_email, :price, :condition, :presence => true
	validates :seller_email, :email => true
	
  def send_seller_buyer_info(buyer_email, body, admin_link)
    UserMailer.send_seller_buyer_email(self.seller_email, buyer_email, body, Book.find_by_id(self.book_id).title, admin_link).deliver
	end
	
	def self.encrypt(posting_id)
	  ((posting_id+10)**16).to_s(36)
	end
	
	def self.decrypt(cyphertext)
	  ((cyphertext.to_i(36)**(1.0/16))-10).to_i
	end
	
end
