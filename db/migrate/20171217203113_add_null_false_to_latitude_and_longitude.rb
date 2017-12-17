class AddNullFalseToLatitudeAndLongitude < ActiveRecord::Migration
  def change
    change_column_null :parking_areas, :latitude, false
    change_column_null :parking_areas, :longitude, false
  end
end
