class ChangeRentalsUserColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :rentals, :user, :user_id
  end
end
