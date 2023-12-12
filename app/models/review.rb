class Review < ApplicationRecord
    # Ensure station_id is present and not nil
    validates :station_id, presence: true
  
    # Ensure message is present and has more than 10 characters
    validates :message, presence: true, length: { minimum: 10 }

    validates :rating, inclusion: { in: 1..5 } # only 1-5

    # Each review belongs to a single user and a single station
    belongs_to :user, class_name: :User, foreign_key: :user_id
    belongs_to :station, class_name: :Station, foreign_key: :station_id
  end
  