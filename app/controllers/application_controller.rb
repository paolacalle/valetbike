class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :require_login, only: [:new_session]
    before_action :check_membership_expiration, if: :user_signed_in?
  
    def require_login
      if user_signed_in?
        logger.info("AUTHENTICATED")
        params[:user_id] = current_user.id
      else 
        redirect_to new_user_session_path
      end
    end

    private
    def check_membership_expiration
      membership = Membership.find_by(user_id: current_user.id)

      logger.info("Checking Membership Expiration")
      
      # To do a simple test you can change the logic to  :) (very good coding here lol)
      # membership && membership.expiration_date > Date.yesterday
      # assuming memebrship is a day

      if membership && membership.expiration_date < Date.yesterday
        membership.destroy
        current_user.update(has_membership: false)
        
        # Notify the user only if they haven't already been notified in this session
        if !session[:notified_membership_expired].present?
          flash[:alert] = "Your membership has expired and has been removed."
          session[:notified_membership_expired] = true # Set the flag
          logger.info("Membership expired and destroyed, user notified.")
        end

      end

    end

  end
  