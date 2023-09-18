class CreateStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stations do |t|
      t.integer :identifier
      t.string :name
      t.string :address

      t.integer :has_kiosk
      t.integer :needs_maintenance
      t.integer :dock_count
      t.integer :docked_bike_count

      t.timestamps
    end
  end
end

#identifier, name, has_kiosk, needs_maintenance, dock_count, docked_bike_count, address