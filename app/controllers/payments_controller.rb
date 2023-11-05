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
      flash[:success] = "Payment complete"
      redirect_to payments_url
    else
      flash.now[:error] = "Payment failed"
      render :new
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
