class User < ApplicationRecord
    validates_presence_of   :first_name, 
                            :last_name, 
                            :email_address, 
                            :password

    validates_uniqueness_of :email_address
end
