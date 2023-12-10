class ChangeMembershipsTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :memberships, :type, :membership_type
  end
end
