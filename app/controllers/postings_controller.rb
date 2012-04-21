class PostingsController < ApplicationController

  def show
    @posting = Posting.find_by_id(params[:posting_id])
    if @posting.nil?
      redirect_to index_path() and return
    end
    @book = Book.find_by_id(@posting.book_id)
  end

  def commit_buy
    if params[:email][:body] == ""
      redirect_to show_posting_path('1') and return
    end
    post = Posting.find_by_id(params[:posting_id])
    post.send_seller_buyer_info(params[:email][:body])
    redirect_to index_path and return
  end

  def display_new
    @book = Book.find_by_id(params[:book_id])
    if @book.nil?
      redirect_to index_path and return
    end
  end

  def create_new
    book = Book.find_by_id(params[:book_id])
    if book.nil?
      redirect_to index_path and return
    end
    if params[:posting][:seller_email] == ""
      redirect_to display_new_posting_path('1') and return
    end
    new_posting_attributes = params[:posting]
    new_posting_attributes[:book_id] = book.id
    new_posting = Posting.create(new_posting_attributes)
    if(new_posting.errors.empty?)
    	flash[:notice] = "Posting Successful"
    else
    	flash[:warning] = "Posting Failed"
    end
    redirect_to index_path and return
  end

end
