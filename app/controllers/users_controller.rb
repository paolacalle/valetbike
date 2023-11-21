class UsersController < ApplicationController

  skip_before_action :require_login, only: [:create, :new]

  #keep login
  def show
    @current_user = User.find(session[:user_id])
    render :show
  end

  def index
    @current_user = User.find(session[:user_id])
  end


  #Sign-up
  def create
    # logger.info("\n\n*****attempting to create new user\n\n")
    # logger.info("\n\n*****In new #{user_params}\n\n")
    @user = User.new(user_params)
    # logger.info("\n\n*****Set new\n\n")
    if @user.save
      session[:user_id] = @user.id
      @user.has_bike = false
      @user.save
      flash[:notice] = "Welcome to your new account."
      redirect_to rentals_path
    else
      puts "Can not create user"
      flash.now[:alert] ||= ""
      @user.errors.full_messages.each do |message|
        flash.now[:alert] << message + ". "
      end
      render :new, status: 500
    end
  end

  private 
  
  def user_params
    logger.info("\n\n*****attempting to create new user\n\n")
    params.permit(:email_address, :password, :password_confirmation, :first_name, :last_name)
  end

  def subscribe
    @user.subscribed = true
  end


end