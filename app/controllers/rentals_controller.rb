class RentalsController < ApplicationController
  def index
    if params[:reverse].blank? || params[:reverse] == "0"
      @rentals = Rental.where(user_id: session[:user_id]).order(rented_at: :desc)
    else 
      @rentals = Rental.where(user_id: session[:user_id]).order(rented_at: :asc)
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
    logger.info("@current_user was set to user ##{@current_user.id}")
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
    @bike = Bike.find(@rental.bike_id)

    if @rental.is_complete?
      flash[:error] = "This rental has already been marked completed"
    else
      dock_bike(@bike)
      
      # Update user bike status 
      @current_user.has_bike=false
      if @current_user.save
        puts "Current user has_bike set to false. Saving rental complete to be true now"
        @rental.is_complete=true
        @rental.returned_at=DateTime.now

        if @rental.save
          flash[:success] << "Rental completed."
        else 
          flash[:error] = "The rental failed to be completed successfully...but the user has_bike is now false"
        end
      else
        flash[:error] ||= "The current user not set has_bike to false."
        @current_user.errors.full_messages.each do |message|
          flash.now[:error] << message + ". \n"
        end
      end
      redirect_to rentals_url
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
      logger.info("@current_user does not have a bike")
      user.update(has_bike: false)
      flash[:error] = "Your account has a nil rental currently...setting to false now. Try again"
      render :new, status: 500
    elsif user.has_bike == false
      process_new_rental(user, rental)
    else
      flash[:error] = "You already have an active rental. Cannot rent multiple bikes before returning"
      redirect_to rentals_url
    end
  end
  
  def process_new_rental(user, rental)
    logger.info("User does not have a bike")
    rental.user = user
    if rental.save
      user.update(has_bike: true)
      dedock_bike(rental)
      flash[:success] << "Rental created. Enjoy your bike!"
      redirect_to payments_url
    else
      flash.now[:error] ||= "Rental was not able to be saved.\n"
      rental.errors.full_messages.each do |message|
        flash.now[:error] << message + ". \n"
      end
      render :new, status: 500
    end
  end

  def dedock_bike(rental)
    bike = Bike.find(rental.bike_id)
    bike.current_station_id = nil
    if bike.save
      flash[:success] = "Bike docked. "
    else
      flash.now[:error] ||= "Unable to de-dock bike.\n"
      bike.errors.full_messages.each do |message|
        flash.now[:error] << message + ". \n"
      end
      render :new, status: 500
    end
  end

  def dock_bike(bike)
    bike.update(current_station_id: params[:new_station_id])
    flash[:success] = "Bike returned. "
    logger.info("Bike docked @ #{@bike.current_station_id}")
  end

end
