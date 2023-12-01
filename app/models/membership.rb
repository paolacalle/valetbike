class Membership < ApplicationRecord
    belongs_to :category #annual, weekly, day, monthly
    belongs_to :user, class_name: :User, foreign_key: :user_id, optional: true

end
