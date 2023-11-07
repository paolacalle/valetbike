class User < ApplicationRecord
    include ActiveModel::SecurePassword
    has_secure_password
    has_secure_password :recovery_password, validations: false

    validates_presence_of   :first_name, 
                            :last_name, 
                            :email_address

    validates_uniqueness_of :email_address

    validates :email_address, format: {with: /\A(^@\s)+@(^@\s)+\z/, message: "Email invalid" }
    attr_accessor :password_digest, :recovery_password_digest
end
