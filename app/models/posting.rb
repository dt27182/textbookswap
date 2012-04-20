class Posting < ActiveRecord::Base
  belongs_to :books

  def send_seller_buyer_info(body)
  end

end
