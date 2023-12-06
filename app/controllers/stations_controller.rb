class StationsController < ApplicationController
  
  def index
    @stations = Station.all
    
    puts "ALLLLLL SESSION #{session.inspect}"
    puts "ALLLLLL parms #{params.inspect}"
    if params[:search_by_address].present? && params[:search_by_address] != ""
      @stations = @stations.where("address LIKE ?", "%#{params[:search_by_address]}%")
    # elsif session[:user_latitude].present? && session[:user_longitude].present? &&
    #       session[:user_latitude] != "" && session[:user_longitude] != ""
    #   @stations = Station.near([session[:user_latitude], session[:user_longitude]], 0.3)
    elsif params[:lat].present? && params[:long].present?
      puts "PARMS NOT EMPTY"
      puts "#{[params[:lat].to_f, params[:long].to_f]}"
      @stations = Station.near([params[:lat].to_f, params[:long].to_f], 1)
      
    end

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
