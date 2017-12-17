class AddUniqueIndexToParkingAreas < ActiveRecord::Migration
  def change
    add_index :parking_areas, [:latitude, :longitude], unique: true
  end
end
