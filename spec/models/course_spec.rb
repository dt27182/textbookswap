require 'spec_helper'

describe Course do

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

end

