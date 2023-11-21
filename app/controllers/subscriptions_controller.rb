class SubscriptionsController < ApplicationController
    def new
        @subscriptions = Subscription.new()
    end

    # this is my attempt to make a simple subscription without stripe
    def create
        @subscription = Subscription.new()
        @current_user = User.find(session[:user_id])
        if !@current_user.subscibed?
            @current_user.subscribed = true
            puts @current_user
            puts session[:user_id]
            @subscription.user = @current_user
            
            if @subscription.save
                flash[:success] = "Rental created"
                redirect_to rentals_url
            else
                flash[:error] = "didn't subscribe"
            end
        else
            flash[:error] = "Already subscribed"
            redirect_to new_membership_path
        end
      end
end
