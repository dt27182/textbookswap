require 'spec_helper'

describe IndexController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "Index Page" do
    
    it "index method should be on the index page" do
      get "index"
      response.should render_template('/')
    end

  end

end
