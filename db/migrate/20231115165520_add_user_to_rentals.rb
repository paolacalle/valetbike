class AddUserToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :user, :integer
  end
end
