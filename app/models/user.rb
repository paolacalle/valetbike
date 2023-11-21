class User < ApplicationRecord
    include ActiveModel::SecurePassword
    # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
    has_secure_password
    has_secure_password :recovery_password, validations: false

    validates_presence_of   :first_name, 
                            :last_name, 
                            :email_address

    validates_uniqueness_of :email_address

    has_one :current_rental, class_name: :Rental, foreign_key: :id
    has_many :rentals, class_name: :Rental, foreign_key: :id

    # validates :email_address, format: {with: EMAIL_REGEX, message: "Email invalid" }

    
    after_save :assign_customer_id 
    def assign_customer_id
        if self.customer_id.blank? 
        customer = Stripe::Customer.create(email: email)
        self.update(customer_id: customer.id)
        end
    end

    def subscribed?
        subscription.present?
    end
end
