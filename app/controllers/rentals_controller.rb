class RentalsController < ApplicationController
  def index
    @rentals = Rental.order(:rented_at)
    render :index
  end

  def new
    @rental = Rental.new
    render :new
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:identifier, :rental_period, :return_by))
    if @rental.save
      flash[:success] = "Rental created!"
      redirect_to rentals_url
      flash[:success] = "Rental created for real!"
    else
      flash.now[:error] = "Rental creation failed"
      render :new
    end
  end

  def show
    @rental = Rental.find(params[:id])
    render :show
  end
  
  def update
  end

  def edit
  end

  def destroy
  end

  
end
