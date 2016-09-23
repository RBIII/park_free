class ParkingArea < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :comments, through: :reviews
  has_many :verifications

  validates :user_id, presence: true
  validates :title, :parking_type, presence: true
  validate :address_or_coordinates

  after_validation :reverse_geocode
  before_update :format_parking_type
  before_save :format_address
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude

  def address_or_coordinates
    !(address.nil? && city.nil? && state.nil? && country.nil? && zip_code.nil?) ||
    !(latitude.nil? && longitude.nil?)
  end

  def full_address
    address + " " + city + " " + state + " " + country + " " + zip_code
  end

  def verified?
    verification_sum = 0
    verifications.each { |v| verification_sum += v.value }
    user.admin || verification_sum >= 3 || verifications.any? { |v| v.user.admin }
  end

  def format_parking_type
    self.parking_type.downcase!
  end

  def format_address
    address_array = self.address.split(",")
    if address_array.length == 4
      self.address = address_array[0].gsub(" ", "")
      self.city = address_array[1].gsub(" ", "")
      self.state = address_array[2].gsub(" ", "").split(" ")[0]
      self.zip_code = address_array[2].gsub(" ", "").split(" ")[1]
      self.country = address_array[3].gsub(" ", "")
    end
  end

  def marker_color
    if parking_type == "free"
      #green
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|009E3D|000000"
    elsif parking_type == "metered"
      #blue
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|0084C6|000000"
    elsif parking_type == "short term"
      #yellow
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|F3C300|000000"
    elsif parking_type == "parking garage"
      #red
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|E00024|000000"
    else
      #charcoal
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|282826|000000"
    end
  end

  def self.convert_address(location_string)
    location_array = location_string.split(",")

    if location_array.length == 4
      return { address: location_array[0], city: location_array[1], state: location_array[2].split(" ")[0],
      zip_code: location_array[2].split(" ")[1], country: location_array[3] }
    end
  end
end
