class AddCategoryIdToMemeberships < ActiveRecord::Migration[7.0]
  def change
    add_column(:memberships, :category_id, :integer, index: true) #annual, weekly, monthy, day
  end
end
