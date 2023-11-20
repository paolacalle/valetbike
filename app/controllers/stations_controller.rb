class StationsController < ApplicationController
  
  def index

    @stations = Station.all.order(identifier: :asc)
    
    if params[:search_by_address] && params[:search_by_address] != ""
      @stations = @stations.where("address LIKE ?", "%#{params[:search_by_address]}%")
    end
    puts @stations
  end

  def show 
    @station = Station.find_by(identifier: params[:id])
    render :show

    if params[:reverse].blank? || params[:reverse] == "0"
      @stations = Station.all.order(identifier: :asc)
    else 
      @stations = Station.all.order(identifier: :desc)
    end

  end
end
