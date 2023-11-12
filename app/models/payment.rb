class Payment < ApplicationRecord
    validates  :credit_card_info, length: { minimum: 16, maximum: 16 }
    validates_presence_of  :amount
end
