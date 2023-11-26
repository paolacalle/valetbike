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
    puts "moved to rentals_controller#create"
    @rental = Rental.new(params.require(:rental).permit(:bike, :rental_hours, :rental_minutes))
    puts "creating rental period"
    rental_period= ""
    rental_period.concat(params[:rental_hours].to_s, params[:rental_minutes].to_s)
    @rental.rental_period = rental_period
    puts @rental.rental_period
    # @bike = Bike.find(params[:bike])
    puts "created...not yet saved"
    @rental.rented_at=DateTime.now
    puts @rental.rented_at
    puts "rental rented_at set to now...not yet saved"
    return_by= (@rental.rented_at + @rental.rental_period[0].to_i.hours + @rental.rental_period[1,2].to_i.minutes)
    puts return_by
    puts "return by created (currently the wrong time though)"
    @current_user = User.find(session[:user_id])
    puts "current_user.has_bike is going to be below"
    puts @current_user.has_bike
    if !@current_user.has_bike #if has bike is false
      puts "User does not have bike"
      @rental.user = @current_user
      @rental.bike = params[:selected_bike_id]
      puts "Set rental user to current user, saving bike now"
      # puts @bike.identifier
      # @bike.current_station_id.delete
      # if @bike.save
        # puts "Set bike current station to nil, saving rental now"
        if @rental.save
          puts "Rental saved, setting current user has_bike to true now"
          @current_user.has_bike=true
          puts "Current user has_bike set to true now. Saving current user"
          if @current_user.save
            flash[:success] = "Rental created"
            redirect_to payments_url
          else
            flash[:error] = "Rental failed. Rental is still attributed to the user, even though the user isn't tracking the rental"
            puts "rental failed. rental is still attributed to the user"
            redirect_to rentals_url
          end
        else
          flash[:error] = "Rental failed. Rental was not able to be saved."
          redirect_to new_rental_path
        end
      # else
      #   flash[:error] = "Rental failed. Bike was not able to be saved."
      #   redirect_to new_rental_path
      # end
    elsif @current_user.has_bike.nil?
      puts "User has bike is nil"
      flash[:error] = "Your account has a nil rental currently...setting to false now. Try again"
      @current_user.has_bike=false
      @current_user.save
      redirect_to new_rental_path
    elsif @current_user.has_bike? #if has bike is true
      puts "User has a bike"
      flash[:error] = "You already have an active rental. Cannot rent multiple bikes before returning"
      redirect_to rentals_url
    else
      puts "user hasbike is none of these :true, false, nil"
      flash[:error] = "Rental creation failed...your rental status is not nil, true, or false. Something is majorly wrong"
      redirect_to new_rental_path
    end
  end

  def show
    @rental = Rental.find(params[:id])
    render :show
  end
  
  def update
    puts "returning rental..."
    @current_user = User.find(session[:user_id])
    @rental=Rental.find(params[:id])
    if @rental.complete?
      flash[:error] = "This rental has already been marked completed"
    else
      @rental.complete=true
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
end
