class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:gmail_address])
            session[:user_id] = user.id
            redirect_to user_path(user)
    end

    def destroy
        session.clear
        redirect_to login_path
    end
end
