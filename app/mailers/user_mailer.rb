class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def send_seller_buyer_email(to_address, buyer_email, comments, book_title, admin_page_link)
    @comments = comments
    @buyer_email = buyer_email
    @book_title = book_title
    @admin_page_link = admin_page_link
    mail(:to => to_address, :subject => "Someone wants to buy your book", :from => "TextbookSwap")
  end
  
  def send_seller_admin_page(to_address, admin_page_link, book_title)
    @admin_page_link = admin_page_link
    @book_title = book_title
    return mail(:to => to_address, :subject => "Important information about your posting on Textbook Swap")
  end

end
