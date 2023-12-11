class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :response

      t.timestamps
    end
  end
end
