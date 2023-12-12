class Feedback < ApplicationRecord
    # Ensure message is present and has more than 20 characters
    validates :response, presence: true, length: { minimum: 20 }
end
