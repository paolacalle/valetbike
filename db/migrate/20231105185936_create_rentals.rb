class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.integer :identifier
      t.datetime :rented_at
      t.datetime :returned_at
      t.integer :rental_period
      t.datetime :return_by

      t.timestamps
    end
  end
end
