class ApplicationController < ActionController::Base
    #declare as helper so accessable to all views
    before_action :require_login

    before_action :set_stripe_key

    def require_login
        #redirect_to new_session_path unless session.include? :user_id
    end

    private 
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def set_stripe_key
        Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    end
end
