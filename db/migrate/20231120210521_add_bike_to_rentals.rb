class AddBikeToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :bike, :integer
  end
end
