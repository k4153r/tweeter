require 'spec_helper'

describe User do
  
  before(:each) do
    @attr={
      :name=>"test user",
      :email=>"test@mail.com",
      :password=>"foobar",
      :password_confirmation=>"foobar"
    }
  end
  
  it "should create a new user given valid attributes" do
    User.create!(@attr)
  end
  it "should require a name to be present before saving" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  it "should require an email address to be present before saving" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  it "should not allow names longer the 51 characters" do
    long_name="a" * 51
    long_name_user=User.create(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end
  it "should accept valid email address" do
    addresses=%w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user=User.new(@attr.merge(:email=>address))
      valid_email_user.should be_valid
    end
  end
  it "should not accept invalid email address" do
    addresses=%w[user@foo,com THE_USER@foo_bar_org first.last@foo.]
    addresses.each do |address|
      valid_email_user=User.new(@attr.merge(:email=>address))
      valid_email_user.should_not be_valid
    end
  end
  it "should not allow duplicate email address" do
    user=User.create!(@attr)
    dup=User.new(@attr)
    dup.should_not be_valid
  end
  
  describe "password validations" do
    it "should require a password" do
      user=User.new(@attr.merge(:password=>"",:password_confirmation=>""))
      user.should_not be_valid
    end
    it "should require the password to match" do
      user=User.new(@attr.merge(:password_confirmation=>"barfoo"))
      user.should_not be_valid
    end
    it "should reject passwords that are too short" do
      password="a"*5
      user=User.new(@attr.merge(:password=>password,:password_confirmation=>password))
      user.should_not be_valid
    end
    it "should reject passwords that are too long" do
       password="a"*41
       user=User.new(@attr.merge(:password=>password,:password_confirmation=>password))
       user.should_not be_valid
    end
    it "should create a new instance given valid attributes" do
        user=User.create!(@attr)
        user.should be_valid
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user=User.create!(@attr)
    end
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    it "should set an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    it "should be true if passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end
    it "should be false if passwords do not match" do
      @user.has_password?('invalidpwd').should be_false
    end
    it "should return a user given a an email address and valid password"do
      matching_user=User.authenticate(@attr[:email],@attr[:password])
      matching_user==@user
    end
  end
  

end
