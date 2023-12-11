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
    @payment.user_id = current_user.id
    @payment.created_at = DateTime.now

    # handling Membership Payments
    if params[:membership_type].present?

      if current_user.has_membership?
        flash[:alert] = "You already have an account. You were not charged anything."
        redirect_to users_show_path
        return
      end

      if @payment.save
        current_user.update(has_payment: true)
        flash[:success] = "Payment completed"
        redirect_to new_membership_path(payment_completed: 1, membership_type: params[:membership_type])
      else
        flash[:error] = "Payment failed"
        render :new, status: :unprocessable_entity
      end

    else
      # handling non-membership Payments

      flash[:success] = "Payment completed"
      @rental = Rental.find(params[:rental_id])
      @rental.update(payment_amount: 0, payment_required: false)
      current_user.update(has_payment: false)

      redirect_to users_show_path
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
