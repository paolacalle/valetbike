class Rental < ApplicationRecord
    validates_presence_of   :rental_period,
                            :return_by
    belongs_to :user, class_name: :User, foreign_key: :id, optional:true
end
