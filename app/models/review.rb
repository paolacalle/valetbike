class Review < ApplicationRecord
    validates_presence_of :user_id
                          :station_id
                          :message
end
