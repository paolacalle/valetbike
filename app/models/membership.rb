class Membership < ApplicationRecord
    #belongs_to :category #annual, weekly, day, monthly
    belongs_to :user, class_name: :User, foreign_key: :user_id

    def is_complete
        if @membership.expiration_date > DateTime.now
            return true
        else
            return false
        end
    end
end
