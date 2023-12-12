class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :confirmable


    validates_presence_of   :first_name, 
                            :last_name, 
                            :email

    validates_uniqueness_of :email
    
    # RENTALS
    has_one :current_rental, class_name: :Rental, foreign_key: :id
    has_many :rentals, class_name: :Rental, foreign_key: :id

    # MEMBERSHIP
    has_many :memberships, class_name: :Membership, foreign_key: :id

    # CUSTOMER FEEDBACK
    has_many :reviews, class_name: :Review, foreign_key: :id
    has_many :feedbacks, class_name: :Feedback, foreign_key: :id

    ## UNCOMMENT IF YOU WANT TO ACTIVATE
    # EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
    # validates :email, format: {with: EMAIL_REGEX, message: "Email invalid" }
end
