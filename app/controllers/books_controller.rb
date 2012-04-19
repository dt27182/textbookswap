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
    new_book = Book.create(params[:new_book])
    if new_book.id.nil?
      redirect_to display_new_book_path(params[:id])
    end
    new_requirement = Requirement.create({:course_id => params[:id], :book_id => new_book.id, :is_required => false})
    display_new_posing_path(new_book.id)
  end

  def show_postings
    @book = Book.find_by_id(params[:book_id])
    if @book.id.nil?
      redirect_to index_path and return
    end
    temp = @book.postings
    @postings = []
    temp.each do |posting|
      if not posting.expired?  #This doesn't work right now
        @postings << posting
      end
   end
  end
end
