class BooksController < ApplicationController
  def display_new
    if Course.find_by_id(params[:id]).nil?
      redirect_to index_path and return
    end
  end

  def create_new
    if Course.find_by_id(params[:id]).nil?
      redirect_to index_path and return
    end
    new_book = Book.create(params[:book])
    if new_book.id.nil?
      redirect_to create_new_book_path(params[:id]) and return
    end
    new_requirement = Requirement.create({:course_id => params[:id], :book_id => new_book.id, :is_required => false})
    redirect_to display_new_posting_path(new_book.id) and return
  end

  def show_postings
    @book = Book.find_by_id(params[:book_id])
    if @book.nil?
      redirect_to index_path and return
    end
    temp = @book.postings
    @postings = []
    expire_days = Misc.find_by_key("expiration_time").value.to_i
    temp.each do |posting|
      if posting.created_at + expire_days.days > Time.now
        @postings << posting
      end
   end
  end
end
