class Station < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates_presence_of    :identifier,
                           :name,
                           :address
  
  validates_uniqueness_of  :identifier
  
  has_many :docked_bikes, class_name: :Bike, foreign_key: :current_station_id

  def address_changed? 
    address? 
  end 
  
end



