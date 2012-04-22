class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def send_seller_buyer_email(to_address, buyer_email, comments, book_title)
    @comments = comments
    @buyer_email = buyer_email
    @book_title = book_title
    mail(:to => to_address, :subject => "Someone wants to buy your book", :from => "TextbookSwap")
  end

end
