class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :require_login, only: [:new_session]
  
    def require_login
      redirect_to new_user_session_path unless user_signed_in?
    end

    private 
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
