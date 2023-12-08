class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    # Render the login form
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      sign_in(user) # Devise method to sign in the user
      flash[:notice] = "You are now logged in"
      redirect_to users_show_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    sign_out(current_user) # Devise method to sign out the user
    flash[:notice] = "You are now signed out"
    redirect_to login_path
  end
end
