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
end
