class AddZipCodeToFreeParkingAreas < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :zip_code, :string
  end
end
