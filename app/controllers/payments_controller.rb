class PaymentsController < ApplicationController
  def index
    @payments = Payment.order(:amount)
    render :index
  end

  def new
    @payment = Payment.new
    render :new
  end

  def create
    @payment = Payment.new(params.require(:payment).permit(:credit_card_info, :amount))
    if @payment.save
      flash[:success] = "Payment completed"
      redirect_to payments_url
    else
      flash[:error] = "Payment failed"
      redirect_to new_payment_path
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
