class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def send_seller_buyer_email(to_address, buyer_email, body)
    @body = body
    @buyer_email = buyer_email
    mail(:to => to_address, :subject => "Someone wants to buy your book", :from => "TextbookSwap")
  end

end
