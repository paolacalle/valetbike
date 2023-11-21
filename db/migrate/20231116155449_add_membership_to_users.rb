class AddMembershipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :subscribed, :boolean)
    add_column(:users, :subscribed_date, :date)
    add_column(:users, :subscribed_end, :date)
  end
end
