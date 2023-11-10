class RemoveIdentifierFromRentals < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :identifier, :integer
  end
end
