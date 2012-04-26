class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def send_seller_buyer_email(to_address, buyer_email, comments, book_title)
    @comments = comments
    @buyer_email = buyer_email
    @book_title = book_title
    mail(:to => to_address, :subject => "Someone wants to buy your book", :from => "TextbookSwap")
  end
  
  def send_seller_admin_page(to_address, link)
    @link = link
    mail(:to => to_address, :subject => "Here is your posting", :from => "TextbookSwap")
  end

end
