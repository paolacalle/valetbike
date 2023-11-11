class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:create, :new]

    def new

    end

    def create
        session_params = params.permit(:email_address, :password)
        @user = User.find_by(email_address: session_params[:email_address])
        logger.info("*** #{@user}")
        if @user && @user.authenticate(session_params[:password])
          session[:user_id] = @user.id
          flash[:notice] = "You've successfully Logged In. Thank you."
          redirect_to root_path
        else
          flash.now[:alert] =  "Login is invalid!"
          render :new
        end
    end

    def destroy
        logger.info("*** Logged out #{cookies[:email_address]}")
        flash[:notice] = "You have been signed out!"

        # do logout process here
        session[:user_id] = nil 
        cookies[:user_name] = nil
        @current_user = nil

        redirect_to login_path
    end
end
