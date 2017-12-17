class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :parking_area
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  validates :user_id, presence: true
  validates :parking_area_id, presence: true
  validates :content, presence: { message: "You must add content to your review" }
  validates :quality, presence: true, inclusion: {in: [1,2,3,4,5]}
  validates_uniqueness_of :user_id, scope: [:parking_area_id], message: "You have already reviewed this parking area"

  def sum_of_votes
    votes.reduce(0) { |sum, vote| sum + vote.value }
  end
end
