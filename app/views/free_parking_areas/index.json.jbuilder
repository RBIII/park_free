json.array!(@free_parking_areas) do |free_parking_area|
  json.extract! free_parking_area, :id, :latitude, :longitude, :address, :description, :title
  json.url free_parking_area_url(free_parking_area, format: :json)
end
