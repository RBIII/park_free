class FreeParkingArea < ActiveRecord::Base
  belongs_to :user
  has_many :verifications
  geocoded_by :full_address
  after_validation :geocode
  before_update :format_params
  validates :user_id, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true
  validates :title, presence: true
  validates :parking_type, presence: true

  def full_address
    address + " " + city + " " + state + " " + country + " " + zip_code
  end

  def verified?
    verification_sum = 0
    verifications.each { |v| verification_sum += v.value }
    user.admin || verification_sum >= 3 || verifications.any? { |v| v.user.admin }
  end

  def format_params
    self.parking_type.downcase!
  end

  def marker_color
    if parking_type == "free"
      #green
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|009E3D|000000"
    elsif parking_type == "metered"
      #blue
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|0084C6|000000"
    elsif parking_type == "2-hour"
      #yellow
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|F3C300|000000"
    elsif parking_type == "parking garage"
      #red
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|E00024|000000"
    else
      #grey
      "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|9FA6AD|000000"
    end
  end
end
