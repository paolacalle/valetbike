class UsersController < ApplicationController
  #keep login
  def show
    @user = current_user.id
    render :show
  end

  def index
    @user = User.find(current_user.id)
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