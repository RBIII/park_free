class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :free_parking_area

  validates :content, presence: true
  validates :user_id, presence: true
  validates :fpa_id, presence: true
end
