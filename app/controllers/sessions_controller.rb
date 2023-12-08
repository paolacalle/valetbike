class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:create, :new]

    def new

    end

    def create
        session_params = params.permit(:email, :password)
        @user = User.find_by(email: session_params[:email])
        if @user && @user.authenticate(session_params[:password])
          session[:user_id] = @user.id
          flash[:notice] = "You are now logged in"
          redirect_to users_show_path
        else
          flash.now[:alert] =  "Login information invalid"
          flash.now[:alert] ||= ""

          render :new, status: 500
        end
    end

    def destroy
        logger.info("*** Logged out #{cookies[:email]}")
        flash[:notice] = "You are now signed out"

        # do logout process here
        session[:user_id] = nil 
        cookies[:user_name] = nil
        @current_user = nil

        redirect_to login_path
    end
end
