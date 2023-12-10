class User < ApplicationRecord
    # Additional columns for email verification
    attr_accessor :pin_0, :pin_1, :pin_2, :pin_3

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

    # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

    validates_presence_of   :first_name, 
                            :last_name, 
                            :email

    validates_uniqueness_of :email
    
    has_one :current_rental, class_name: :Rental, foreign_key: :id
    has_many :rentals, class_name: :Rental, foreign_key: :id

    # validates :email, format: {with: EMAIL_REGEX, message: "Email invalid" }

    # Email Verification Callbacks
    after_create :update_user_verified_column_to_true
    after_create :send_pin!

    # Method to update the user's email verification status to true
    def update_user_verified_column_to_true
        # Perform the email verification process after user creation
        UpdateUserJob.perform_now(self)
    end

    # Method to reset the PIN for email verification
    def reset_pin!
        update_column(:pin, rand(1000..9999))
    end

    # Method to unverify the user's email
    # sets the email verification status to "false" to allow re-verification.
    def unverify!
        update_column(:verified, false)
    end

    # Method to send the PIN for email verification
    # sets the verification status to "false," 
    # triggers a background job to send the PIN to the user.
    def send_pin!
        reset_pin!
        unverify!
        # Perform the job to send the PIN
        SendPinJob.perform_now(self)
    end
end
