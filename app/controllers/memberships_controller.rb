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
    logger.info("Starting the membership creation process.")
  
    # Check if the user already has a membership
    if current_user.has_membership
      logger.info("User already has a membership.")
      flash[:error] = "You already have a membership."
      redirect_to memberships_url
      return
    end
  
    @membership = Membership.new()

    # Check if payment was made
    if !current_user.has_payment?
      # Logic to create a payment method
      # Redirect to payment method creation if necessary
      logger.info("User does not have a payment method.")
      redirect_to new_payment_path(membership_type: params[:membership_type])
      return
    end

    @membership.membership_type = params[:membership_type]
    # Assign expiration date based on membership type
    case @membership.membership_type
    when "day"
      @membership.expiration_date = 1.day.from_now
    when "month"
      @membership.expiration_date = 1.month.from_now
    when "year"
      @membership.expiration_date = 1.year.from_now
    else
      logger.error("Invalid membership type.")
      render :new, status: 500
      return
    end
  
    # Save the membership
    @membership.user_id = current_user.id
    @membership.cost = Payment.find_by(user_id: current_user.id).amount
    if @membership.save
      current_user.update(has_membership: true)
      current_user.update(has_payment: false) #payment was used
      flash[:success] = "Welcome to ValetBike! You are now a member for #{@membership.membership_type}."
      redirect_to users_show_path
    else
      logger.error("Failed to save membership.")
      flash[:error] = @membership.errors
      render :new, status: 500
    end

  end
  
  def edit
    @membership = Membership.find(params[:id])
  end

  def update

  end 

  def delete 
    logger.info("in delete!")
  end
  
  def destroy
    @membership = Membership.find(user_id: current_user.id)
    @membership.destroy
    logger.info("Membership destroyed?: #{@membership}")
    current_user.has_membership = false
    logger.info("user has_membership: #{@user.has_membership}")
    redirect_to membership_path
  end

  # def expiration_check
  #   @membership = Membership.find_by(user_id: current_user.id)
  
  #   # Check if the membership is expired
  #   if @membership && @membership.expiration_date < Date.today
  #     @membership.destroy
  #     current_user.update(has_membership: false)
  #     logger.info("Membership expired and destroyed.")
  #   else
  #     logger.info("Membership not expired.")
  #   end

  # end

  private 
  def membership_params
    logger.info("\n\n*****attempting to create new membership\n\n")
    params.permit(:expiration_date, :created_at, :id, :cost, :membership_type, :updated_at, :category_id)
  end
end
