class AddStateToFreeParkingAreas < ActiveRecord::Migration
  def change
    add_column :free_parking_areas, :state, :string
  end
end
