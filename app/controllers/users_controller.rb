class UsersController < ApplicationController

  def new
    @title="Sign up"
    @user=User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title="#{@user.name}"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #handle success
      @title=@user.name
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      #reset user password
      @user.password=""
      @title = "Sign up"
      render 'new'
    end
  end
end
