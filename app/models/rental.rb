class Rental < ApplicationRecord
    validates_presence_of   :rental_period,
                            :return_by
    belongs_to :user, class_name: :User, foreign_key: :user_id, optional: true
    belongs_to :bike, class_name: :Bike, foreign_key: :bike_id
end
