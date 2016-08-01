class Verification < ActiveRecord::Base
  belongs_to :user
  belongs_to :parking_area
  validates :user_id, presence: true
  validates :parking_area_id, presence: true
end
