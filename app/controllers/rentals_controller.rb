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
      logger.info("***** Creating a new rental in rentals_controller#create")
    @rental = Rental.new(params.require(:rental).permit(:bike_id, :rental_period, :return_by))
    # @bike = Bike.find(params[:bike])
      logger.info("@rental created but not yet saved")
    @rental.rented_at=DateTime.now
      logger.info("@rental.rented_at set to now")
      logger.info("@current_user will be set to user # #{User.find(session[:user_id]).id}")
    @current_user = User.find(session[:user_id])
      logger.info("@current_user was set to user ##{@current_user.id}")
      logger.info("@current_user.has_bike = #{@current_user.has_bike}")
    if !@current_user.has_bike #if has bike is false
      logger.info("@current_user does not have a bike")
      @rental.user = @current_user
      logger.info("@rental.user just set to @current_user")

      #below is the parameter stuff that doesnt pass the bike info over
      logger.info("selected_bike_id param is #{params[:selected_bike_id]}") 
      # @rental.bike_id = Bike.find(params[:selected_bike_id]) #ryan tried this
      @rental.bike = params[:selected_bike_id]
      
      logger.info("@rental.bike just set to #{@rental.bike}")
      puts "Set rental user to current user, saving bike now"
      # puts @bike.identifier
      # @bike.current_station_id.delete
      # if @bike.save
        # puts "Set bike current station to nil, saving rental now"
        if @rental.save
          logger.info("@rental.save was a success")
          @current_user.has_bike=true
          if @current_user.save
            logger.info("@current_user.save was a success")
            flash[:success] = "Rental created"
            redirect_to payments_url
          else
            logger.info("*** Rental failed to @current_user.save #{@rental.errors.full_messages}. Rental was saved and is still attributed to the user")
            flash[:error] = "Rental failed. Rental is still attributed to the user, even though the user isn't tracking the rental."
            redirect_to rentals_url
          end
        else
          logger.info("*** Rental failed to @rental.save")
          flash[:error] = "Rental failed. Rental was not able to be saved. #{@rental.errors.full_messages}"
          redirect_to new_rental_path
        end
      # else
      #   flash[:error] = "Rental failed. Bike was not able to be saved."
      #   redirect_to new_rental_path
      # end
    elsif @current_user.has_bike.nil?
      logger.info("@current_user.has_bike is nil...setting to false")
      flash[:error] = "Your account has a nil rental currently...setting to false now. Try again"
      @current_user.has_bike=false
      @current_user.save
      logger.info("@current_user.save was a success")
      redirect_to new_rental_path
    elsif @current_user.has_bike? #if has bike is true
      logger.info("@current_user.has_bike is true")
      flash[:error] = "You already have an active rental. Cannot rent multiple bikes before returning"
      redirect_to rentals_url
    else
      logger.info("@current_user.has_bike is neither true, false, nor nil")
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
end
