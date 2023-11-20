class Rental < ApplicationRecord
    validates_presence_of   :rental_period,
                            :return_by
    belongs_to :user, class_name: :User, foreign_key: :id, optional: true
    has_one :bike, class_name: :Bike, foreign_key: :id
end
