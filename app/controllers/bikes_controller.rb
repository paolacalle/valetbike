class BikesController < ApplicationController
    def index
        @bikes = Bike.all.order(identifier: :asc)

    end

end
