class AddCurrentRentalToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_rental, :integer
  end
end
