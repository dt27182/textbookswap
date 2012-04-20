class Posting < ActiveRecord::Base

  belongs_to :books
  validates :seller_email, :price, :condition, :comments, :presence => true

  def send_seller_buyer_info(buyer_email, body)
    UserMailer.send_seller_buyer_email(self.seller_email, buyer_email, body).deliver
  end

end
