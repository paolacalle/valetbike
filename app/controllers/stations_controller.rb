class StationsController < ApplicationController
  
  def index
    @stations = Station.all

    # session.each do |key, value|
    #   logger.info "IN INDEX FOR STATION Session key: #{key}, value: #{value}"
    # end
    
    if params[:search_by_address].present? && params[:search_by_address] != ""
      @stations = @stations.where("address LIKE ?", "%#{params[:search_by_address]}%")
    end

    if params[:search_nearest] == "1"

      if session[:user_latitude].present? && session[:user_longitude].present? &&
            session[:user_latitude] != "" && session[:user_longitude] != ""

        puts "READING FROM SESSION"
        @stations = @stations.near([session[:user_latitude].to_f, session[:user_longitude].to_f], 0.3)
      elsif params[:lat].present? && params[:long].present?
        puts "PARMS NOT EMPTY"
        puts "#{[params[:lat].to_f, params[:long].to_f]}"
        @stations = @stations.near([params[:lat].to_f, params[:long].to_f], 0.3)
        session[:user_latitude] = params[:lat].present
        session[:user_latitude]
      end
     
    end
    puts @stations
    order = params[:reverse] == "1" ? :desc : :asc

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
