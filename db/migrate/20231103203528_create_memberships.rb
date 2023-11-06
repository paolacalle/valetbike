class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.string :type
      t.float :cost
      t.date :expiration_date

      t.timestamps
    end
  end
end
