class AddPaymentFieldsToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :payment_required, :boolean, default: false
    add_column :rentals, :payment_amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
