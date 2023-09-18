class Station < ApplicationRecord
  validates_presence_of    :identifier,
                           :name,
                           :address
  attribute  :has_kiosk
  attribute :needs_maintenance
  attribute :dock_count
  attribute :docked_bike_count
  
  validates_uniqueness_of  :identifier
  
  has_many :docked_bikes, class_name: :Bike, foreign_key: :current_station_id
  
end
