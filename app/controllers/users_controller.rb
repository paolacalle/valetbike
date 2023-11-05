class UsersController < ApplicationController
  def index
    @user = User.order(:price)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = Users.new 
  end

  def edit
    @user = Users.find(params[:id])
  end

  def delete
  end 

  def full_name 
    [first_name, last_name].join(' ')
  end 
end
