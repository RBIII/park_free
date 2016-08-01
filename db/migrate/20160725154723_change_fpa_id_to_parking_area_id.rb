class ChangeFpaIdToParkingAreaId < ActiveRecord::Migration
  def change
    rename_column :verifications, :free_parking_area_id, :parking_area_id
    rename_column :comments, :fpa_id, :parking_area_id
  end
end
