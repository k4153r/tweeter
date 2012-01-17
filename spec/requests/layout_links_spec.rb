require 'spec_helper'

describe "LayoutLinks" do
  
  before(:each) do
     @base_title="Sample App | "
   end
   
  describe "GET /layout_links" do
    it "should have a homepage at /" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/'
      response.should have_selector('title', :content=>@base_title+'Home')
    end
    it "should have a Contact page at /contact" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/contact'
      response.should have_selector('title', :content=>@base_title+'Contact')
    end
    it "should have a About page at /about" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/about'
      response.should have_selector('title', :content=>@base_title+'About')
    end
    it "should have a Help page at /help" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/help'
      response.should have_selector('title', :content=>@base_title+'Help')
    end
    it "should have a Sign up page at /signup" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/signup'
      response.should have_selector('title', :content=>@base_title+'Sign up')
    end
    
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title',:content=>@base_title+'About')
      click_link "Help"
      response.should have_selector('title',:content=>@base_title+'Help')
      click_link "Contact"
      response.should have_selector('title',:content=>@base_title+'Contact')
      click_link "Home"
      response.should have_selector('title',:content=>@base_title+'Home')
      click_link "Sign up now!"
      response.should have_selector('title',:content=>@base_title+'Sign up')
    end
  end
end
