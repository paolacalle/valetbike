class Rental < ApplicationRecord
    validates_presence_of   :rental_period,
                            :return_by
    validates :rental_period, numericality: { only_integer: true }
end
