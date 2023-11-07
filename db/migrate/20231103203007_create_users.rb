class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address, null: false
      t.boolean :has_bike
      t.string :password_digest

      t.timestamps
    end
  end
end

# change combined up and down method 
# allows you to drop users and add users