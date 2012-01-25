require 'spec_helper'

describe UsersController do

  render_views
  
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content=>"Sign up")
    end
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end
    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    it "should have an password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end
    it "should have an password confirm field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
    
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user=Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the correct user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    it "should include the users name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class=>"gravatar")
    end
  end
  
  describe "POST 'create'" do
    describe "Failure" do
      before (:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User,:count)
      end
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      it "should render the new page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end#failure
    
    describe "Success" do
      before (:each) do
        @attr = {:name => "Test User", :email => "test.user@example.com", :password => "barfoos", :password_confirmation => "barfoos"}
      end
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      it "should redirect to user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      it "should flash a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~/Welcome to the Sample App/i
      end
    end#success
  end
  
end
