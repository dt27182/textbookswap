require 'spec_helper'

describe IndexController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "clicking the buy button" do
    
    it "should redirect to the Buy Pick Course Page" do
      get "buy"
      response.should render_template('/buy/course')
    end
    
    it "should not redirect to the Sell Pick Course Page" do 
      get "buy"
      response.should_not render_template('/sell/course')
    end
    
  end
  
  describe "clicking the sell button" do
  
    it "should redirect to the Sell Pick Course Page" do
      get "sell"
      response.should render_template('/sell/course')
    end
  
    it "should not redirect to the Buy Pick Course Page" do 
      get "sell"
      response.should_not render_template('/buy/course')
    end
  
  end

end
