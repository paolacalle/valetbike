class RentalsController < ApplicationController
  def index
    if params[:reverse].blank? || params[:reverse] == "0"
      @rentals = Rental.all.order(rented_at: :desc)
    else 
      @rentals = Rental.all.order(rented_at: :asc)
    end
    render :index
  end

  def new
    @rental = Rental.new
    render :new
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.rented_at = DateTime.now
  
    @current_user = User.find(session[:user_id])
    rental_creation(@current_user, @rental)
  end
  
  def show
    @rental = Rental.find(params[:id])
    render :show
  end
  
  def update
    puts "returning rental..."
    @current_user = User.find(session[:user_id])
    @rental=Rental.find(params[:id])

    Bike.find(@rental.bike_id).update(current_station_id: params[:new_station_id])
    
    if @rental.is_complete?
      flash[:error] = "This rental has already been marked completed"
    else
      @rental.is_complete=true
      @rental.returned_at=DateTime.now
      puts @rental.returned_at
      @current_user.has_bike=false
      if @current_user.save
        puts "current user has_bike set to false. saving rental complete to be true now"
        if @rental.save
          flash[:success] = "Rental completed successfully"
          puts @rental.returned_at
          redirect_to rentals_url
        else 
          flash[:error] = "The rental failed to be completed successfully...but the user has_bike is now false"
          redirect_to rentals_url
        end
      else
        flash[:error] = "The current user not set has_bike to false. Something went wrong"
      end
    end
  end

  def edit
  end

  def destroy
  end

  private
  
  def rental_params
    params.require(:rental).permit(:bike_id, :rental_period, :return_by).merge(bike_id: params[:selected_bike_id])
  end
  
  def rental_creation(user, rental)
    if user.has_bike.nil?
      user.update(has_bike: false)
      flash[:error] = "Your account has a nil rental currently...setting to false now. Try again"
      redirect_to new_rental_path
    elsif user.has_bike == false
      process_new_rental(user, rental)
    else
      flash[:error] = "You already have an active rental. Cannot rent multiple bikes before returning"
      redirect_to rentals_url
    end
  end
  
  def process_new_rental(user, rental)
    rental.user = user

    if rental.save
      user.update(has_bike: true)
      dedock_bike(rental)
      flash[:success] = "Rental created"
      redirect_to payments_url
    else
      flash[:error] = "Rental failed. Rental was not able to be saved. #{rental.errors.full_messages}"
      render :new, status: 500
    end
  end

  def dedock_bike(rental)
    bike = Bike.find(rental.bike_id)
    bike.current_station_id = nil
    bike.save
    flash[:success] = "Bike dedocked"
  end
end
