class PaymentsController < ApplicationController
  def index
    if params[:reverse].blank? || params[:reverse] == "0"
      @payments = Payment.all.order(id: :asc)
    else 
      @payments = Payment.all.order(id: :desc)
    end
    render :index
  end

  def new
    @payment = Payment.new
    render :new
  end

  def create
    logger.info("in payments create")
    @payment = Payment.new(params.permit(:credit_card_info, :amount))
    logger.info("created new payment")
    @current_user = User.find(session[:user_id])
    @membership = Membership.find(session[:user_id])

    # define payment amount
    if @membership.membership_type == "day"
      logger.info("type is day")
      @payment.amount = 10
    elsif @membership.membership_type == "month"
      @payment.amount = 20
    elsif @membership.membership_type == "year"
      @payment.amount = 200
    else
      flash[:error] = "Payment failed"
      redirect_to memberships_path
    end

    @payment.user_id = @current_user.id
    @payment.created_at = DateTime.now

    if @payment.save
      logger.info("payment saves")
      @payment.save
      @current_user.has_payment = true
      @current_user.has_membership = true
      if @current_user.save
        logger.info("current user saves")
        @current_user.save
        flash[:success] = "Payment completed"
        #render :new, status:500
        redirect_to rentals_path
      else
      flash[:error] = "Payment failed"
      redirect_to new_payment_path
      end
    else
      logger.info("payment doesnt save")
      flash[:error] = "Payment failed"
    end
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end

end
