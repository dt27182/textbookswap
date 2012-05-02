require 'spec_helper'

describe Book do

  before :each do
    @fake_agent = ""
    @fake_page = ""
    Mechanize.stub(:new).and_return(@fake_agent)
    @fake_agent.stub(:get).and_return(@fake_page)
    Misc.create!(:key => "semester", :value => "spring")
    Misc.create!(:key => "year", :value => "2012")
    @course = Course.create!(:department_long => "Computer Science",:department_short => "COMPSCI", :name => "Software Eng", :number => "169", :section => "001", :term => "spring", :year => 2012, :teacher => "Armando")
  end

  describe "getting books" do
  
    before :each do
      Book.stub(:set_semester_and_year)
      Book.stub(:get_books_from_page)
    end
    
    it "should set the semester" do
      Book.should_receive(:set_semester_and_year)
      Book.get_books
    end
    
    it "should get books for each course" do
      Book.should_receive(:get_books_from_page)
      Book.get_books
    end
    
  end
  
  describe "setting the semester and year" do
  
    before :each do
      @fake_form = ""
      @fake_form.stub(:username=)
      @fake_form.stub(:password=)
      @fake_form.stub(:current_semester=)
      @fake_page.stub(:form).and_return(@fake_form)
      @fake_agent.stub(:submit).and_return(@fake_page)
      @parser = ""
      @xpath = ""
      @fake_page.stub(:parser).and_return(@parser)
      @parser.stub(:xpath).and_return(@xpath)
      @xpath.stub(:to_html).and_return('"86">Spring 2012</option')
    end
  
    it "should set the username and password" do
      @fake_form.should_receive(:username=).with("textbookswap@berkeley.edu")
      @fake_form.should_receive(:password=).with("goodbooks")
      Book.set_semester_and_year(@fake_agent, "spring", 2012)
    end
    
    it "should find the value of the current semester" do
      @fake_form.should_receive(:current_semester=).with("86")
      Book.set_semester_and_year(@fake_agent, "spring", 2012)
    end
    
    it "should submit the forms" do
      @fake_agent.should_receive(:submit).twice
      Book.set_semester_and_year(@fake_agent, "spring", 2012)
    end
    
  end
  
  describe "getting books from the books page" do
  
    before :each do
      @parser = ""
      @xpath = ""
      @fake_page.stub(:parser).and_return(@parser)
      @lecture1, @lecture2 = "", ""
      @lecture1.stub(:content).and_return("001")
      @lecture2.stub(:content).and_return("002")
      @lectures = [@lecture1, @lecture2]
      @title = ""
      @title.stub(:content).and_return("Intro to Software Engineering")
      @other1, @other2, @other3 = "", "", ""
      @other1.stub(:content).and_return("Armando Fox")
      @other2.stub(:content).and_return("ISBN-10: 1558764313 ISBN-13: 9781558764316 Edition: Revised ")
      @other3.stub(:content).and_return("List Price: $44.95")
      @parser.stub(:xpath).with("/html/body/div/div/div/div/div[@id='tab-books']//h4").and_return(@lectures)
      @parser.stub(:xpath).with("//div[@id='tab-books']//table[1]//h5").and_return([@title])
      @parser.stub(:xpath).with("//div[@id='tab-books']//table[1]//li").and_return([@other1, @other2, @other3])
      @fake_book = Book.new
    end
    
    it "should return the books for that section" do
      Book.should_receive(:new).with(:title => "Intro to Software Engineering", :author => "Armando Fox", :suggested_price => "44", :edition => "Revised", :isbn => "9781558764316").and_return(@fake_book)
      Book.get_books_from_page(@fake_page, @course)
    end
    
    it "should not return the books for other sections" do
      Book.stub(:new).and_return(@fake_book)
      @fake_book.should_receive(:save).exactly(1)
      Book.get_books_from_page(@fake_page, @course)
    end
  end

end

  
