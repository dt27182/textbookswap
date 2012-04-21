class Posting < ActiveRecord::Base

  belongs_to :books
  validates :seller_email, :price, :condition, :presence => true
	validates :seller_email, :email => {:mx => true, :message => I18n.t('validations.errors.models.user.invalid_email')}
	
  def send_seller_buyer_info(buyer_email, body)
    UserMailer.send_seller_buyer_email(self.seller_email, buyer_email, body).deliver
	end
end
