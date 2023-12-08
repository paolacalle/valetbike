class AddHasPaymentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :has_payment, :boolean
  end
end
