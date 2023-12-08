class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :require_login, only: [:new_session]
  
    def require_login
      logger.info("AUTHENTICATED")
      if user_signed_in?
        params[:user_id] = current_user.id
      else 
        redirect_to new_user_session_path
      end
    end
  end
  