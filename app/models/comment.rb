class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :content, presence: true
  validates :user_id, presence: true
  validates :review_id, presence: true
end
