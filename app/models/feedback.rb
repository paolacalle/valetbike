class Feedback < ApplicationRecord
    # Ensure message is present and has more than 20 characters
    validates :response, presence: true, length: { minimum: 20 }

    # Each feedback belongs to a single user
    belongs_to :user, class_name: :User, foreign_key: :user_id
end
