require 'spec_helper'

describe Book do
	describe 'test many to many relationship with course' do
		describe 'course1 should have 2 required books' do
			it '' do
				#Course.create!(:number => '169')
				#course1 = Course.find_by_number('169')
				#assert course1.books[0].requirement.is_required && course1.books[1].requirement.is_required
				@course1 = Course.create!(:number => '169')
				@course2 = Course.create!(:number => '170', :name => 'algorithms')
				@course1.save!
				@course2.save!
				@book1 = Book.create!(:title => 'book')
				@book2 = Book.create!(:title => 'another book', :author => 'john smith', :isbn => '0000000000001')
				@book1.save!
				@book2.save!
				course1 = Course.find_by_number('169')
				course1.should_not == nil
				course2 = Course.find_by_number('170')
				course2.should_not == nil
				book1 = Book.find_by_title('book')
				book1.should_not == nil
				book2 = Book.find_by_title('another book')
				book2.should_not == nil
				@course2.books << @book1
				@course2.save!
				@book1.save!
				Course.find_by_number('169').books.length.should == 1
			end
		end
		describe 'course2 should have 1 required book and 1 non-required book' do
		end
	end
end

