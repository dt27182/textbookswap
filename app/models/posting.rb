class Posting < ActiveRecord::Base

  belongs_to :books
  validates :seller_email, :price, :condition, :comments, :presence => true

  def send_seller_buyer_info(body)
    UserMailer.test_email("akaiser2@mac.com").deliver
  end

end
