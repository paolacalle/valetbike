class Users::SessionsController < ApplicationController
    def destroy
        session.delete(:user_id) # clear custom session
        super
    end
end
