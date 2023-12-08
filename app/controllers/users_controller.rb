class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]

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
    @user.has_bike = false
    # logger.info("\n\n*****Set new\n\n")
    if @user.save
      sign_in(@user)
      session[:user_id] = @user.id
      ApplicationMailer.welcome_email(@user).deliver

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


  # Save user coordniates
  def save_coordinates
    puts "USERRRRRRRRRRRRRRR ********** #{params[:latitude]} and #{params[:longitude]}"
    session[:user_latitude] = params[:latitude]
    session[:user_longitude] = params[:longitude]

    session.each do |key, value|
      logger.info "Session key: #{key}, value: #{value}"
    end
    
    render json: { message: 'Coordinates saved successfully: '}
  end

  private 
  
  def user_params
    logger.info("\n\n*****attempting to create new user\n\n")
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

end