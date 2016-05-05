class AddCityToFreeParkingAreas < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :city, :string
  end
end
