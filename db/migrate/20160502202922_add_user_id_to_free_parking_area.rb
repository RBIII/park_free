class AddUserIdToFreeParkingArea < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :user_id, :integer, null: false
  end
end
