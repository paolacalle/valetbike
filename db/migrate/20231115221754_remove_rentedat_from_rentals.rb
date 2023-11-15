class RemoveRentedatFromRentals < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :rented_at, :datetime
  end
end
