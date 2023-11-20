class AddCompleteToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :complete, :boolean
  end
end
