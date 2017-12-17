class ParkingArea < ActiveRecord::Base
  PARKING_TYPES = ["Free", "Metered", "Short Term", "Parking Garage", "Other"]

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :comments, through: :reviews
  has_many :verifications

  validates :user_id, presence: true
  validates :title, :parking_type, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :latitude, uniqueness: { scope: :longitude }
  validates :addresss, uniqueness: { scope: [:city, :state, :country, :zip_code]}

  before_validation :reverse_geocode, if: :has_latlag?
  before_validation :geocode, if: :has_address?, unless: :has_latlag?
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude
  before_update :format_parking_type

  def has_latlag?
    latitude && longitude
  end

  def has_address?
    address && city && state && country && zip_code
  end

  def verified?
    verification_sum = 0
    verifications.each { |v| verification_sum += v.value }
    user.admin || verification_sum >= 3 || verifications.any? { |v| v.user.admin }
  end

  def full_address
    address + " " + city + " " + state + " " + country + " " + zip_code
  end

  def format_parking_type
    parking_type.downcase!
  end

  def marker_color
    if parking_type == "free"
      #green
      "https://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|009E3D|000000"
    elsif parking_type == "metered"
      #blue
      "https://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|0084C6|000000"
    elsif parking_type == "short term"
      #yellow
      "https://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|F3C300|000000"
    elsif parking_type == "parking garage"
      #red
      "https://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|E00024|000000"
    else
      #charcoal
      "https://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|282826|000000"
    end
  end

  def self.convert_address(location_string)
    location_array = location_string.split(",")

    if location_array.length == 4
      return { address: location_array[0], city: location_array[1], state: location_array[2].split(" ")[0],
      zip_code: location_array[2].split(" ")[1], country: location_array[3] }
    end
  end

  def get_user_verification(user)
    user ? Verification.find_by(user_id: user.id, parking_area_id: self.id) : nil
  end

  def get_reviews
    reviews.includes(:user).sort_by {|r| r.sum_of_votes }.reverse!
  end
end
