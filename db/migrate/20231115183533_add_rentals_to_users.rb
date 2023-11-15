class AddRentalsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rental, :integer
  end
end
