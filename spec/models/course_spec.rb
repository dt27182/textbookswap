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
      @book1 = Book.create!(:title => 'Engineering Long Lasting Software', :author => "Armando Fox", :edition => "First", :isbn => "80-902734-1-6")
      @book1.save!
      @book2 = Book.create!(:title => 'Armando Fox Autobiography', :author => "Dave Patterson", :edition => "Second", :isbn => "85-359-0277-5")
      @book2.save!
      @book3 = Book.create!(:title => 'David Patterson Autobiography', :author => "Us", :edition => "Thrid", :isbn => "1-84356-028-3")
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

  describe "getting teacher values from a course" do

    before(:each) do
      @fake_agent = ""
      Mechanize.stub(:new).and_return @fake_agent
      @fake_course_page = ""
      @fake_form = ""
      @fake_form.stub(:p_dept=)
      @fake_form.stub(:p_course=)
      @fake_form.stub(:p_title=)
      @fake_course_page.stub(:form).and_return @fake_form
      @fake_detailed_page = "Detailed Course Page"
      @fake_agent.stub(:submit).and_return @fake_detailed_page
      @fake_root = "Root"
      @fake_detailed_page.stub(:root).and_return @fake_root
      @fake_element1, @fake_element2, @fake_element3, @fake_element4 = "", "", "", ""
      @fake_element5, @fake_element6 = "", ""
      @fake_element = ""
      @fake_element.stub(:content).and_return "gibberish"
      @fake_element1.stub(:content).and_return "Course"
      @fake_element2.stub(:content).and_return "Computer Science 61A P 001 LEC"
      @fake_element3.stub(:content).and_return "Computer Science 61A P 002 LEC"
      @fake_element4.stub(:content).and_return "Computer Science 61A P 001 SEC"
      @fake_element5.stub(:content).and_return "Harvey"
      @fake_element6.stub(:content).and_return "Armando"
      @fake_elements = [@fake_element1,
                        @fake_element2,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element5,
                        @fake_element,
                        @fake_element,
                        @fake_element1,
                        @fake_element4,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element1,
                        @fake_element3,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element,
                        @fake_element6,
                        @fake_element]
      @fake_root.stub(:css).and_return @fake_elements
      @course = {:department_short => "COMPSCI", :name => "Structure and Interp of Programming", :number => "61A"}
    end

    it "should set the form values" do
      @fake_form.should_receive(:p_dept=).with "COMPSCI"
      @fake_form.should_receive(:p_course=).with "61A"
      @fake_form.should_receive(:p_title=).with "Structure and Interp of Programming"
      pairs = Course.get_teacher(@fake_course_page, @course)
    end

    it "should submit the form" do
      @fake_agent.should_receive(:submit).with @fake_form
      pairs = Course.get_teacher(@fake_course_page, @course)
    end

    it "should correct if there is a ..." do
      @course[:name] = "Structure and Interp of Programming..."
      @fake_form.should_receive(:p_title=).with "Structure and Interp of Programming"
      pairs = Course.get_teacher(@fake_course_page, @course)
    end

    it "should return both teacher pairs" do
      pairs = Course.get_teacher(@fake_course_page, @course)
      pairs.should == [["Harvey", "001"], ["Armando", "002"]]
    end
  end



end

