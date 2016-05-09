class AddFreeParkingAreaIdToVerifications < ActiveRecord::Migration
  def change
    add_column :verifications, :free_parking_area_id, :integer, null: false
  end
end
