class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.integer :parking_area_id
      t.integer :user_id
      t.timestamps
    end
  end
end
