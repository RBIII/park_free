class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :parking_area
  has_many :comments
  ratyrate_rateable "rating"

  validates :user_id, presence: true
  validates :parking_area_id, presence: true
  validates :content, presence: true
end
