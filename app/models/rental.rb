class Rental < ApplicationRecord
    validates_presence_of   :rental_period,
                            :return_by
end
