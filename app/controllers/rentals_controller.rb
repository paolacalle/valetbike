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
    @rental = Rental.new(params.require(:rental).permit(:rental_period, :return_by))
    if @rental.save
      puts "saved new rental"
      flash[:success] = "Rental created!"
      redirect_to rentals_url
    else
      puts "failed to save new rental"
      flash[:error] = "Rental creation failed"
      render(action: :new)
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
