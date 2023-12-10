class AddHasMembershipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :has_membership, :boolean
  end
end
