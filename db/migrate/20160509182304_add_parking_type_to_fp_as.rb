class AddParkingTypeToFpAs < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :parking_type, :string
  end
end
