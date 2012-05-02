class PostingsController < ApplicationController

  def show
    @posting = Posting.find_by_id(params[:posting_id])
    if @posting.nil?
    	flash[:warning] = "The requested posting id does not exist"
      redirect_to index_path() and return
    end
    @book = @posting.book
  end

  def commit_buy
    if params[:email][:body] == ""
    	flash[:warning] = "Please fill in all the fields"
      redirect_to show_posting_path(params[:posting_id]) and return
    end
    if !params[:email][:buyer_email].match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
    	flash[:warning] = "Please fill in the required fields"
    	redirect_to show_posting_path(params[:posting_id]) and return
    end
    post = Posting.find_by_id(params[:posting_id])
    if post.nil?
    	flash[:warning] = "Buy request failed because the given post id does not exist"
    	redirect_to index_path and return
    else
			post.send_seller_buyer_info(params[:email][:buyer_email], params[:email][:body])
			post.reserved = true
			post_reserved_success = post.save!
			if(post_reserved_success)
    		flash[:notice] = "Buy request submitted! We have emailed the seller your message & contact information!"
    		redirect_to index_path and return
    	else
    		flash[:warning] = "Buy request failed because of database error"
    		redirect_to index_path and return
    	end
    end
  end

  def display_new
    @book = Book.find_by_id(params[:book_id])
    if @book.nil?
    	flash[:warning] = "The given book id does not exist"
      redirect_to index_path and return
    end
  end

  def create_new
    book = Book.find_by_id(params[:book_id])
    if book.nil?
    	flash[:warning] = "Posting failed because the given book id does not exist"
      redirect_to index_path and return
    end
    if params[:posting][:seller_email] == ""
    	flash[:warning] = "Posting failed because you did not enter a valid email"
      redirect_to display_new_posting_path(params[:book_id]) and return
    end
    new_posting_attributes = params[:posting]
    new_posting_attributes[:book_id] = book.id
    new_posting = Posting.create(new_posting_attributes)
    new_posting.book_id = book.id
    new_posting.save
    if(new_posting.errors.empty?)
    	UserMailer.send_seller_admin_page(new_posting.seller_email, display_admin_posting_path(Posting.encrypt(new_posting.id)), new_posting.book.title).deliver
    	flash[:notice] = "Book posting submitted! We will e-mail you if someone wishes to buy your book!"
    	redirect_to index_path and return
    else
    	flash[:warning] = "Posting failed. Please fill in all the form data."
    	redirect_to display_new_posting_path(params[:book_id]) and return
    end
  end
  
  def admin
  	posting_id = Posting.decrypt(params[:unique_string])
  	@posting = Posting.find_by_id(posting_id)
  	if @posting.nil?
  		flash[:warning] = "The requested posting does not exist"
  		redirect_to index_path and return
  	end
  	@book = @posting.book
  end
  
  def commit_edit_and_republish
  	posting_id = Posting.decrypt(params[:unique_string])
  	posting = Posting.find_by_id(posting_id)
  	if posting.nil?
  		flash[:warning] = "The requested posting does not exist"
  		redirect_to index_path and return
  	end
  	posting.update_attributes(params[:new_post])
  	if(posting.errors.empty?)
  		posting.reserved = false
  		posting.save!
			flash[:notice] = "Your updated post has been republished!"
			redirect_to show_posting_path(posting_id)
  	else
  		flash[:warning] = "The update failed because some form fields are invalid"
  		redirect_to display_admin_posting_path(params[:unique_string])
  	end
  end
  
  def delete
  	posting_id = Posting.decrypt(params[:unique_string])
  	posting = Posting.find_by_id(posting_id)
  	if posting.nil?
  		flash[:warning] = "The requested posting does not exist"
  	end
  	posting.destroy
  	flash[:notice] = "Post Successfully Deleted!"
  	redirect_to index_path
  end
end
