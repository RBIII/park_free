class RenameCommentsColumn < ActiveRecord::Migration
  def change
    rename_column :comments, :parking_area_id, :review_id
    add_column(:comments, :created_at, :datetime, null: false)
    add_column(:comments, :updated_at, :datetime, null: false)
  end
end
