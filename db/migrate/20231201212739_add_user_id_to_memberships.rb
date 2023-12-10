class AddUserIdToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :user_id, :integer
  end
end
