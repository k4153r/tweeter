require 'spec_helper'

describe "Users" do
  describe "Sign up" do
    describe "Failure" do
      it "should not create a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "Success" do
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Anonymous User"
          fill_in "Email", :with => "anon.user@example.com"
          fill_in "Password", :with => "barfly1"
          fill_in "Confirmation", :with => "barfly1"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
    
  end
end
