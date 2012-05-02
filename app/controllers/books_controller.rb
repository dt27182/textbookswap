class BooksController < ApplicationController
  def display_new
    if Course.find_by_id(params[:id]).nil?
      redirect_to index_path and return
    end
    @course = Course.find_by_id(params[:id])
    @refill_book_fields = nil
    @failed_book = nil
    if !session[:failed_new_book].nil?
    	@failed_book = session[:failed_new_book]
    else
    	@failed_book = {:title => "", :author => "", :edition => "", :isbn => ""}
    end
  end

  def create_new
    if Course.find_by_id(params[:id]).nil?
    	flash[:warning] = "The course you requested does not exist"
      redirect_to index_path and return
    end
    existing_book = Book.find(:first, :conditions => ["title = :title AND author = :author AND edition = :edition AND isbn = :isbn", params[:book]])
    if existing_book.nil?
    	new_book = Book.create(params[:book])
    	if new_book.id.nil?
    		if new_book.errors[:isbn].empty?
    			flash[:warning] = "Book creation failed. Please fill in all the fields"
    		else
    			flash[:warning] = "Book creation failed. Your isbn is not formated correctly. Please include the '-'s and make sure the isbn is either 10 or 13 digits long."
    		end
    		session[:failed_new_book] = params[:book]
      	redirect_to create_new_book_path(params[:id]) and return
    	end
    	new_requirement = Requirement.create({:course_id => params[:id], :book_id => new_book.id, :is_required => false})
    	redirect_to display_new_posting_path(new_book.id) and return
    else
    	new_requirement = Requirement.create({:course_id => params[:id], :book_id => existing_book.id, :is_required => false})
    	redirect_to display_new_posting_path(existing_book.id) and return
    end
  end

  def show_postings
    @odd = true
    @book = Book.find_by_id(params[:book_id])
    if @book.nil?
    	flash[:warning] = "Cannot show postings because the given book id is invalid"
      redirect_to index_path and return
    end
    temp = @book.postings
    @postings = []
    expire_days = Misc.find_by_key("expiration_time").value.to_i
    temp.each do |posting|
      if (posting.updated_at + expire_days.days > Time.now && !posting.reserved)
        @postings << posting
      end
   end
  end
end
