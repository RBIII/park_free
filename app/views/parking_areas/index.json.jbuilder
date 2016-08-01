json.array!(@parking_areas) do |parking_area|
  json.extract! parking_area, :id, :latitude, :longitude, :address, :description, :title
  json.url parking_area_url(parking_area, format: :json)
end
