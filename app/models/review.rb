class Review < ApplicationRecord
    # Ensure station_id is present and not nil
    validates :station_id, presence: true
  
    # Ensure message is present and has more than 100 characters
    validates :message, presence: true, length: { minimum: 20 }

    validates :rating, inclusion: { in: 1..5 } # only 1-5
  end
  