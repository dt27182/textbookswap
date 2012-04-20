class Posting < ActiveRecord::Base
	belongs_to :books
	validates :seller_email, :price, :condition, :reserved, :comments, :presence => true
end
