class Membership < ApplicationRecord
    belongs_to :category #annual, weekly, day, monthly

end
