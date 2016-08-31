class AddNullFalseToReviewColumns < ActiveRecord::Migration
  def change
    change_column :reviews, :parking_area_id, :integer, null: false
    change_column :reviews, :user_id, :integer, null: false
  end
end
