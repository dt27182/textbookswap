class Posting < ActiveRecord::Base

  belongs_to :books
  validates :seller_email, :price, :condition, :presence => true
	validates :seller_email, :email => {:mx => true, :message => I18n.t('validations.errors.models.user.invalid_email')}
	
  def send_seller_buyer_info(body)
    UserMailer.test_email("akaiser2@mac.com").deliver
  end

end
