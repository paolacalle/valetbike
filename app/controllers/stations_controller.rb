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

      if !params[:dist].nil? 
        @dist = params[:dist]
      else 
        @dist = 0.3 
      end 

      if session[:user_latitude].present? && session[:user_longitude].present? &&
            session[:user_latitude] != "" && session[:user_longitude] != ""

        @stations = @stations.near([session[:user_latitude].to_f, session[:user_longitude].to_f], @dist)
      elsif params[:lat].present? && params[:long].present?
        puts "PARMS NOT EMPTY"
        puts "#{[params[:lat].to_f, params[:long].to_f]}"
        @stations = @stations.near([params[:lat].to_f, params[:long].to_f], @dist)
        session[:user_latitude] = params[:lat]
        session[:user_longitude] = params[:long]
      end
     
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
