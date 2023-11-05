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
