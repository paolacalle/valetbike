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
    @current_user = User.find(session[:user_id])
    if @current_user.has_bike.nil? 
      flash[:error] = "Your account has a nil rental currently...setting to false. try again"
      @current_user.has_bike=false
      @current_user.save
      redirect_to new_rental_path
    elsif @current_user.has_bike? #if has bike is true
      flash[:error] = "You already have an active rental. Cannot rent multiple bikes before returning...that feature soon to be released"
      redirect_to rentals_url
    elsif !@current_user.has_bike #if has bike is false
      @current_user.has_bike=true
      @current_user.current_rental=@rental
      @current_user.save
      @current_user.has_bike = true
      @current_user.save
      puts @current_user.has_bike?
      puts @current_user
      puts session[:user_id]
      @rental.user = @current_user
      puts @rental.user
      if @rental.save
        flash[:success] = "Rental created"
        redirect_to rentals_url
      else
        flash[:error] = "Rental creation failed"
        redirect_to new_rental_path
      end
    else
      flash[:error] = "Rental creation failed...your rental status is not nil, true, or false. something is majorly wrong"
    end
  end

  def show
    @rental = Rental.find(params[:id])
    render :show
  end
  
  def update
    puts "returning rental..."
    @current_user = User.find(session[:user_id])
    Rental.find(id: @current_user.current_rental.to_i).returned_at=DateTime.now
    puts @current_user.current_rental.returned_at
    @current_user.current_rental=nil
    puts @current_user.current_rental
    @current_rental.has_bike=false
    puts @current_rental.has_bike
    puts "rental returned...hopefully"
  end

  def edit
  end

  def destroy
  end
  
end
