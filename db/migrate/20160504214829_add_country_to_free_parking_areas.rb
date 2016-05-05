class AddCountryToFreeParkingAreas < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :country, :string
  end
end
