class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:error] = "Error- please try to create an account again."
      redirect_to :new
    end
  end

  private 
  
  def user_params
    params.require(:user).permit(:gmail_address, :password)
  end

end