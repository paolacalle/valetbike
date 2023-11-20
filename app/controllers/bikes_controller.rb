class BikesController < ApplicationController
    def index
      @bikes = Bike.all
  
      if params[:selected_station_id].present?
        session[:selected_station_id] = params[:selected_station_id]
        @bikes = @bikes.where(current_station_id: params[:selected_station_id])
      elsif session[:selected_station_id]
        @bikes = @bikes.where(current_station_id: session[:selected_station_id])
      end

      order = params[:reverse] == "1" ? :desc : :asc
      @bikes = @bikes.order(identifier: order)
    end

  end
  