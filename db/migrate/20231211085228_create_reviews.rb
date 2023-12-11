class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :station_id
      t.string :message

      t.timestamps
    end
  end
end
