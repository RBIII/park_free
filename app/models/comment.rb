class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :parking_area

  validates :content, presence: true
  validates :user_id, presence: true
  validates :parking_area_id, presence: true
end
