class Feedback < ApplicationRecord
    # Ensure message is present and has more than 10 characters
    validates :response, presence: true, length: { minimum: 10 }
end
