require 'spec_helper'

describe Book do
	describe 'test many to many relationship with course' do
		before :each do
			@course1 = FactoryGirl.build(:course, :number => '169')
			@course2 = FactoryGirl.build(:course, :number => '170', :name => 'algorithms')
			@course1.save!
			@course2.save!
			@book1 = FactoryGirl.build(:book)
			@book2 = FactoryGirl.build(:book, :title => 'another book', :author => 'john smith', :isbn => '0000000000001')
			@book1.save!
			@book2.save!
			@course1.books << @book1
			@course1.books << @book2
			@course1.books[0].requirement.is_required = true
			@course1.books[1].requirement.is_required = true
			@course1.save!
			@course2.books << @book1
			@course2.books << @book2
			@course2.books[0].requirement.is_required = true
			@course2.books[1].requirement.is_required = false
			@course2.save!
		end
		describe 'course1 should have 2 required books' do
			course1 = Course.find_by_number('169')
			course1.books
		end
		describe 'course2 should have 1 required book and 1 non-required book' do
		end
	end
end

