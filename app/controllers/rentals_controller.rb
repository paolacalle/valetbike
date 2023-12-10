class RentalsController < ApplicationController
  def index
    if params[:reverse].blank? || params[:reverse] == "0"
      @rentals = Rental.where(user_id: current_user.id).order(rented_at: :desc)
    else 
      @rentals = Rental.where(user_id: current_user.id).order(rented_at: :asc)
    end
    render :index

  end

  def new
    @rental = Rental.new
    render :new
  end

  def create
    logger.info("entered into create")

    puts params.inspect
    puts "moved to rentals_controller#create"
    @rental = Rental.new(rental_params)
    @user = current_user
    logger.info("@user was set to user ##{@user.id}")
    puts params.inspect
    logger.info("new rental created with rental_params")

    puts "creating rental period"
    @rental_period= ""
    @rental_period.concat(params[:rental_hours].to_s, params[:rental_minutes].to_s)
    # @bike = Bike.find(params[:bike])
    puts "created...not yet saved"
    @rented_at=DateTime.now.in_time_zone(nil)
    puts @rented_at
    logger.info("rental_period ")
    puts @rental_period
    @return_by= (@rented_at + @rental_period[0].to_i.hours + @rental_period[1,2].to_i.minutes)
    puts @return_by
    puts "return by created"
    logger.info("@user was set to user ##{@user.id}")
    @rental.rented_at = @rented_at
    puts @rental.rented_at
    @rental.rental_period = @rental_period
    @rental.return_by = @return_by
    rental_creation(@user, @rental)
  end
  
  def show
    @rental = Rental.find(params[:id])
    render :show
  end
  
  def update
    puts "returning rental..."
    @user = current_user
    @rental=Rental.find(params[:id])
    @bike = Bike.find(@rental.bike_id)

    if @rental.is_complete?
      flash[:error] = "This rental has already been marked completed"
    else
      dock_bike(@bike)
      
      # Update user bike status 
      @user.has_bike=false

      if @user.save
        puts "Current user has_bike set to false. Saving rental complete to be true now"
        @rental.is_complete = true
        @rental.returned_at = DateTime.now
      
        if @rental.returned_at > @rental.return_by
          puts "Calculating late fees"
          late_seconds = (@rental.returned_at - @rental.return_by).to_i
      
          late_fee_rate = 0.0005
          late_fee = late_fee_rate * late_seconds
      
          @rental.payment_amount += late_fee
        end
      
        # Set payment_required to true if payment_amount is greater than 0
        @rental.payment_required = @rental.payment_amount > 0
      
        if @rental.save
          flash[:success] = "Rental completed."
      
          # Redirect only if payment is required
          if @rental.payment_required
            flash[:alert] = "You Have Late Fee!"
            redirect_to new_payment_path(amount: @rental.payment_amount, rental_id: @rental.id)
            return
          else 
            redirect_to rentals_url
            return
          end 

        else 
          flash[:error] = "The rental failed to be completed successfully...but the user has_bike is now false"
          redirect_to rentals_url
          return
        end

      else

        flash[:error] = "The current user not set has_bike to false."
        @user.errors.full_messages.each do |message|
          flash.now[:error] << message + ". \n"
        end
        redirect_to rentals_url
        return
      end 

    end
  end


  def edit
  end

  def destroy
  end

  private
  
  def rental_params
    params.permit(:bike_id, :rented_at).merge(bike_id: params[:selected_bike_id])
  end
  
  def rental_creation(user, rental)
    if user.has_bike.nil?
      logger.info("@user does not have a bike")
      user.update(has_bike: false)
      flash[:error] = "Your account has a nil rental currently...setting to false now. Try again"
      render :new, status: 500
    elsif Rental.where(payment_required: true, user_id: user.id).exists? #prob ineffienct, but best way I can think of rn
      flash[:error] = "Payment needed for previous rental."
      redirect_to rentals_url
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
      flash[:success] << "Rental created."

      if user.has_membership
        flash[:success] << " Your a member so no payment needed."
        rental.update(payment_amount: 0.0)
        redirect_to users_show_path
      else
        # Calculate the total duration in seconds
        total_seconds = params[:rental_hours].to_i * 3600 + params[:rental_minutes].to_i * 60
        # Calculate the total price: 1$ per hr
        total_price = 0.0003 * total_seconds
        rental.update(payment_required: true, payment_amount: total_price)

        redirect_to new_payment_path(amount: total_price, rental_id: rental.id)
      end

    else
      logger.info("rental didn't save")
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
      logger.info("bike got dedocked")
      flash[:success] = "Bike dedocked. "
    else
      logger.info("bike not dedocked")
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
