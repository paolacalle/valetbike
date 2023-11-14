class ApplicationController < ActionController::Base
    #declare as helper so accessable to all views
    before_action :require_login

    def require_login
        redirect_to new_session_path unless session.include? :user_id
        
    end

    def logged_in?
        !current_user.nil?
    end

    private 
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
