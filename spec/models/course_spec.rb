require 'spec_helper'

describe Course do

=begin Comment
  before do
    course_one = FactoryGirl.build(:course)
    course_two = FactoryGirl.build(:course, :term => "summer")
    course_three = FactoryGirl.build(:course, :term => "fall")
  end

  describe "Course model methods" do

    describe "get_term_acronym method" do

      if "should return the right term acronym for spring" do
        get_term_acronym(course_one.term).should == "SP"
      end

      if "should return the right term acronym for summer" do
        get_term_acronym(course_two.term).should == "SU"
      end

      if "should return the right term acronym for fall" do
        get_term_acronym(course_three.term).should == "FA"
      end
    end
  end
=end

  describe 'test ability to find required and unrequired book IDs' do
    before do
      @course1 = Course.create!(:number => '169', :name => "Software Engineering", :department_short => "CompSci", :department_long => "Computer Science", :teacher => "Armando Fox", :section => "001", :year => 2012, :term => "spring")
      @course1.save!
      @book1 = Book.create!(:title => 'Engineering Long Lasting Software', :author => "Armando Fox", :edition => "First", :isbn => 1234567890)
      @book1.save!
      @book2 = Book.create!(:title => 'Armando Fox Autobiography', :author => "Dave Patterson", :edition => "Second", :isbn => 1234567899)
      @book2.save!
      @book3 = Book.create!(:title => 'David Patterson Autobiography', :author => "Us", :edition => "Thrid", :isbn => 1234567888)
      @book3.save!
      @requirement1 = Requirement.create!(:course_id => @course1.id, :book_id => @book1.id, :is_required => true)
      @requirement1.save!
      @requirement2 = Requirement.create!(:course_id => @course1.id, :book_id => @book2.id, :is_required => false)
      @requirement2.save!
      @requirement3 = Requirement.create!(:course_id => @course1.id, :book_id => @book3.id, :is_required => false)
      @requirement3.save!
    end

    it 'should find required books' do
      textbooks = @course1.find_required_and_unrequired_books
      textbooks[0].member?(@book1).should == true
      textbooks[0].member?(@book2).should == false
      textbooks[0].member?(@book3).should == false
    end

    it 'should find unrequired books' do
      textbooks = @course1.find_required_and_unrequired_books
      textbooks[1].member?(@book1).should == false
      textbooks[1].member?(@book2).should == true
      textbooks[1].member?(@book3).should == true
    end
  end

end

