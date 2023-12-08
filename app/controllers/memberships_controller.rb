class MembershipsController < ApplicationController
  def index
    @membership = Membership.order(:price)
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def new
    @membership = Membership.new 
  end

  def create
    logger.info("got to create")
    @current_user = User.find(session[:user_id])
    logger.info("found user: @current_user.user_id")
    # create new membership
    #@membership = Membership.new(params.require(:expiration_date).permit(:created_at, :id, :cost, :type, :updated_at, :category_id))
    if !@current_user.has_membership
      logger.info("user doesn't have payment")
      # make new membership
      @membership = Membership.new(membership_params)
      # associate with user
      @membership.user = @current_user
      # associate with user_id
      @membership.user_id = @current_user.id

      logger.info("heloooo")
      logger.info("user user_id: #{@current_user.id}")
      logger.info("membership user_id: #{@membership.user_id}")
      logger.info("membership id: #{@membership.id}")

      # assign expiration date based on membership_type
      if @membership.membership_type == "day"
        logger.info("membership type: #{@membership.membership_type}")
        @membership.expiration_date = 1.day.from_now
        logger.info("expiration date set. it is: #{@membership.expiration_date}")

      elsif @membership.membership_type == "month"
        @membership.expiration_date = 1.month.from_now

      elsif @membership.membership_type == "year"
        @membership.expiration_date = 1.year.from_now

      else
        logger.info("membership type didn't save correctly")
      end


      logger.info("membership created, redirecting to payment")
      redirect_to new_payment_path

    elsif @current_user.has_payment
      logger.info("user has payment")
      @membership = Membership.find(session[:user_id])
      logger.info("found membership: @membership.id")
      # set created_at to now
      @membership.created_at=DateTime.now
      # set current_user
      logger.info("User.find: #{User.find(session[:user_id])}")
      logger.info("user id: #{@current_user.id}")
      
      # if user doesn't have a membership already
      if !@current_user.has_membership
        logger.info("user doesn't have a membership")
        # assign user to membership



        @membership.save
        # user now has membership
        @current_user.has_membership = true
        logger.info("Type: #{@membership.membership_type}")
        logger.info()

        # if save is successful
        if @membership.save
          @membership.save
          puts("save was successful!")
          if @current_user.save
            @current_user.save
            puts("user saved!")
            flash[:success] = "Welcome to ValetBike! You are now a member"
          end

        else
          puts("save was not successful!")
          puts("Type: #{@membership.membership_type}")
        end
        
      # if user does have a membership
      elsif @current_user.has_membership
        flash[:error] = "You are already a member until #{@membership.expiration_date}!"
        # redirect back to membership page   
        redirect_to memberships_url

      else
        puts("something went wrong")
      end
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update

  end 

  def delete 

  end
  
  def destroy

  end


  private 

  
  def membership_params
    logger.info("\n\n*****attempting to create new membership\n\n")
    params.permit(:expiration_date, :created_at, :id, :cost, :membership_type, :updated_at, :category_id)
  end
end
