class UsersController < ApplicationController
  skip_before_action :require_login, only:[:new, :create] #requires login 

  def index
    @user = User.order(:price)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new 
  end

  def edit
    @user = User.find(params[:id])
  end

  def delete
  end 

  def create
    @user = User.new({email_address: params[:email_address], 
                      first_name: params[:first_name],
                      last_name: params[:last_name],
                      password: params[:password]})

    puts @user

    if @user.save #if save is sucessful 
      redirect_to rentals_path
    else
      render :new
    end
  end
end
