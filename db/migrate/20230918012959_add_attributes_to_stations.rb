# to add these attributes, I ran rails generate migration AddAttributesToStations has_kiosk:boolean needs_maintenance:boolean dock_count:integer docked_bike_count:integer
# then, rails db:migrate
# I was experiencing an error beacuse the schema and mirgate did not match

class AddAttributesToStations < ActiveRecord::Migration[7.0]
  def change
    add_column :stations, :has_kiosk, :boolean
    add_column :stations, :needs_maintenance, :boolean
    add_column :stations, :dock_count, :integer
    add_column :stations, :docked_bike_count, :integer
  end
end
