class AddTimestampsToFreeParkingAreas < ActiveRecord::Migration
  def change_table
    add_column(:free_parking_areas, :created_at, :datetime, null: false)
    add_column(:free_parking_areas, :updated_at, :datetime, null: false)
  end
end
