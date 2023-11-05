class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :credit_card_info

      t.timestamps
    end
  end
end
