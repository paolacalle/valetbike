class RentalsController < ApplicationController
  def index
    if params[:reverse].blank? || params[:reverse] == "0"
      @rentals = Rental.all.order(id: :asc)
    else 
      @rentals = Rental.all.order(id: :desc)
    end
    render :index
  end

  def new
    @rental = Rental.new
    render :new
  end

  def create
    @rental = Rental.new(params.require(:rental).permit(:rental_period, :return_by))
    puts User.find(session[:user_id])
    puts session[:user_id]
    @rental.user = User.find(session[:user_id])
    if @rental.save
      flash[:success] = "Rental created"
      redirect_to rentals_url
    else
      flash[:error] = "Rental creation failed"
      redirect_to new_rental_path
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

  private 
    
  
end
