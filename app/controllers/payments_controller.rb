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

    if @payment.save

      if params[:membership_type].present?

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
        flash[:success] = "Payment completed"
        @rental = Rental.find(params[:rental_id])
        @rental.update(payment_amount: 0, payment_required: false)

        redirect_to users_show_path
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
