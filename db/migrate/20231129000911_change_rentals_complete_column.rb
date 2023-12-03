class ChangeRentalsCompleteColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :rentals, :complete, :is_complete
  end
end
