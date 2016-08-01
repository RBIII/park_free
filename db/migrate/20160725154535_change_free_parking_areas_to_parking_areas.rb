class ChangeFreeParkingAreasToParkingAreas < ActiveRecord::Migration
  def change
    rename_table :free_parking_areas, :parking_areas
  end
end
