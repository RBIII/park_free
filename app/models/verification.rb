class Verification < ActiveRecord::Base
  belongs_to :user
  belongs_to :free_parking_area
  validates :user_id, presence: true
  validates :free_parking_area_id, presence: true
end
