class User < ApplicationRecord
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
end
