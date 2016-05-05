class FreeParkingArea < ActiveRecord::Base
  belongs_to :user
  geocoded_by :full_address
  after_validation :geocode
  validates :user_id, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true
  validates :title, presence: true

  def full_address
    address + " " + city + " " + state + " " + country + " " + zip_code
  end
end
