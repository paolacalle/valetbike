class ChangeRentalsBikeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :rentals, :bike, :bike_id
  end
end
