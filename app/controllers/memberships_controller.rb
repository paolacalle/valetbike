class MembershipsController < ApplicationController
  def index
    @membership = Membership.order(:price)
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def new
    @membership = Membership.new 
  end

  def create
    puts("got to create")
    # create new membership
    #@membership = Membership.new(params.require(:expiration_date).permit(:created_at, :id, :cost, :type, :updated_at, :category_id))
    @membership = Membership.new(params.permit(:expiration_date, :created_at, :id, :cost, :type, :updated_at, :category_id))
    # set created_at to now
    @membership.created_at=DateTime.now
    # set current_user
    @current_user = User.find(session[:user_id])
    puts("User.find: #{User.find(session[:user_id])}")
    puts("user id: #{@current_user.id}")
    
    # if user doesn't have a membership already
    if !@current_user.has_membership
      puts("we made it to first if")
      # assign user to membership
      @membership.user = @current_user
      # user now has membership
      @current_user.has_membership = true

      # if save is successful
      if @current_user.save
        puts("save was successful!")
        flash[:success] = "Welcome to ValetBike!"
         #redirect to user profile page - I dont think this is the right url
        redirect_to users_url
      end

    # if user does have a membership
    elsif @current_user.has_membership
      flash[:error] = "You are already a member until #{@membership.expiration_date}!"
      # redirect back to membership page   
      redirect_to memberships_url
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update

  end 

  def delete 

  end
  
  def destroy

  end
end
