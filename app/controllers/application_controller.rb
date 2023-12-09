class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :require_login, only: [:new_session]
  
    def require_login
      if user_signed_in?
        logger.info("AUTHENTICATED")
        params[:user_id] = current_user.id
      else 
        redirect_to new_user_session_path
      end
    end
  end
  