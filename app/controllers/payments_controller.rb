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

    # define payment balance
    if params[:membership_type] == "day"
      logger.info("type is day")
      @payment.amount = 10
    elsif params[:membership_type] == "month"
      @payment.amount = 20
    elsif params[:membership_type] == "year"
      @payment.amount = 200
    else
      flash[:error] = "Payment failed"
      redirect_to users_show_path
    end

    @payment.user_id = current_user.id
    @payment.created_at = DateTime.now

    if @payment.save
      logger.info("payment saves")
      @payment.save
      current_user.has_payment = true
      if current_user.save
        logger.info("current user saves")
        flash[:success] = "Payment completed"
        redirect_to new_membership_path(payment_completed: 1, membership_type: params[:membership_type])
      else
        flash[:error] = "Payment failed"
        render :new, status: 500
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
