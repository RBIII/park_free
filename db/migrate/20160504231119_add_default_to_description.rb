class AddDefaultToDescription < ActiveRecord::Migration
  def change
    change_column :free_parking_areas, :description, :string, default: "N/A"
  end
end
