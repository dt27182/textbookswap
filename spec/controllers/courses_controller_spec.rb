require 'spec_helper'

describe CoursesController do

  before :each do
    @fake_course = mock('Course', :id => '1', :department_long => "Computer Science", :number => "169", :section => "001", :term => "spring", :year => 2012)
    @fake_course_list = [@fake_course]
    @fake_book = mock('Book', :id => '1', :title => "a book")
    @fake_list_one = ['Computer Science']
    @fake_list_two = ['169']
    @fake_list_three = ['001']
    @for_each_one = ['Computer Science']
    @for_each_two = ['169']
    @for_each_three = ['001']
    @answer_one = ['Computer Science']
    @answer_two = ['169']
    @answer_three = ['001']

  end

  describe "check if it is on the right page" do

    it "should be on the buy course page" do
      get :show, {:transaction_type => "buy"}
      response.should be_success
    end

    it "should be on the sell course page" do
      get :show, {:transaction_type => "sell"}
      response.should be_success
    end

  end

  describe "show method" do

    it "should call select methods with the Course model" do
      Course.stub(:select).with("department_long").and_return(@for_each_one)
      @for_each_one.stub(:each).and_return(@answer_one)
      Course.stub(:select).with("number").and_return(@for_each_two)
      @for_each_two.stub(:each).and_return(@answer_two)
      Course.stub(:select).with("section").and_return(@for_each_three)
      @for_each_three.stub(:each).and_return(@answer_three)
      Course.should_receive(:select).with(anything()).exactly(3).times
      get :show, {:transaction_type => "buy"}
    end

    it "should set the @departments in the CoursesController to list of departments" do
      Course.stub(:select).and_return([@fake_course])
      get :show, {:transaction_type => "buy"}
      assigns(:departments).should == @answer_one
    end

    it "should set the @numbers in the CoursesController to list of numbers" do
      Course.stub(:select).and_return([@fake_course])
      get :show, {:transaction_type => "buy"}
      assigns(:numbers).should == @answer_two
    end

    it "should set the @sections in the CoursesController to the list of sections" do
      Course.stub(:select).and_return([@fake_course])
      get :show, {:transaction_type => "buy"}
      assigns(:sections).should == @answer_three
    end
    it "should call select, unique, each for departments and numbers" do
      Course.should_receive(:select).with(anything()).exactly(3).times.and_return(@fake_course_list)
      @fake_course_list.should_receive(:each).exactly(3).times
      get :show, {:transaction_type => "buy"}
    end
  end

  describe "find" do
    describe "after buyer chooses a course and course number" do
      it "should call the find method in the Course model" do
        Course.should_receive(:find).with(:first, :conditions => {:term => "spring", :year => 2012, :department_long => "Computer Science", :number => "169", :section => "001"}).and_return(@fake_course)
        post :find, {:transaction_type => 'buy', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
      end
      describe "success path" do
        it "should redirect to the buyer's show books page" do
          Course.stub(:find).and_return(@fake_course)
          post :find, {:transaction_type => 'buy', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should redirect_to(show_books_path('buy','1'))
        end

        it "should not redirect to the seller's book listings page" do
          Course.stub(:find).and_return(@fake_course)
          post :find, {:transaction_type => 'buy', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should_not redirect_to(show_books_path('sell','1'))
        end
      end
      describe "fail path" do
        it "should redirect to the select a course page" do
          Course.stub(:find).and_return(nil)
          post :find, {:transaction_type => 'buy', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should redirect_to(show_courses_path('buy'))
        end
      end
    end

    describe "after seller chooses a course and course number" do
      it "should call the find_by_department_long_and_number method in the Course model" do
        Course.should_receive(:find).with(:first, :conditions => {:term => "spring", :year => 2012, :department_long => "Computer Science", :number => "169", :section => "001"}).and_return(@fake_course)
        post :find, {:transaction_type => 'sell', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
      end
      describe "success path" do
        it "should redirect to the seller's show books page" do
          Course.stub(:find).and_return(@fake_course)
          post :find, {:transaction_type => 'sell', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should redirect_to(show_books_path('sell','1'))
        end

        it "should not redirect to the buyer's book listings page" do
          Course.stub(:find).and_return(@fake_course)
          post :find, {:transaction_type => 'sell', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should_not redirect_to(show_books_path('buy','1'))
        end
      end
      describe "fail path" do
        it "should redirect to the select a course page" do
          Course.stub(:find).and_return(nil)
          post :find, {:transaction_type => 'sell', :course => { :department => 'Computer Science', :number => '169', :section => "001" } }
          response.should redirect_to(show_courses_path('sell'))
        end
      end
    end
  end

  describe "show_books" do
    describe "buy path" do
      it "should call the find_by_id method in the Course model" do
        Course.should_receive(:find_by_id).with('1').and_return(@fake_course)
        @fake_course.stub(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'buy', :id => '1'}
      end

      it "should call the find_required_and_unrequired_books method in the Course model" do
        Course.stub(:find_by_id).and_return(@fake_course)
        @fake_course.should_receive(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'buy', :id => '1'}
      end
      it "should render the buy side list of books template" do
        Course.stub(:find_by_id).and_return(@fake_course)
        @fake_course.stub(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'buy', :id => '1'}
        response.should render_template("show_books")
      end
    end
    describe "sell path" do
      it "should call the find_by_id method in the Course model" do
        Course.should_receive(:find_by_id).with('1').and_return(@fake_course)
        @fake_course.stub(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'sell', :id => '1'}
      end

      it "should call the find_required_and_unrequired_books method in the Course model" do
        Course.stub(:find_by_id).and_return(@fake_course)
        @fake_course.should_receive(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'sell', :id => '1'}
      end
      it "should render the sell side list of books template" do
        Course.stub(:find_by_id).and_return(@fake_course)
        @fake_course.stub(:find_required_and_unrequired_books).and_return([[@fake_book],[@fake_book]])
        get :show_books, {:transaction_type => 'sell', :id => '1'}
        response.should render_template("show_books")
      end
    end
  end

  describe "inputing courses into the database" do
    it "should but a course into the database" do
      @fake_agent, @fake_course_page, @fake_object = "", "", ""
      @num, @name, @dep_long, @department = "", "", "", ""
      @department.stub(:content).and_return("COMPSCI")
      @num.stub(:content).and_return("   61B")
      @name.stub(:content).and_return("Data Structures")
      @dep_long.stub(:content).and_return("Computer Science")
      @fake_list = [@department, @num, @name]
      @fake_list_2 = ["", "", "", @dep_long]
      Mechanize.stub(:new).and_return(@fake_agent)
      @fake_agent.stub(:get).and_return(@fake_course_page)
      @fake_course_page.stub(:root).and_return(@fake_object)
      @fake_object.stub(:css).with('body td td label').and_return(@fake_list)
      @fake_object.stub(:css).with("body td td font").and_return(@fake_list_2)
      Course.stub(:get_teacher).and_return([["Fox", "001"], ["Patterson", "002"]])
      get :input, {:term => "spring", :year => "2012"}
      Course.find_by_teacher("Fox").name.should == "Data Structures"
      Course.find_by_teacher("Patterson").number.should == "61B"
    end
  end

end

