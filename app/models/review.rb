class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :parking_area
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  ratyrate_rateable "rating"

  validates :user_id, presence: true
  validates :parking_area_id, presence: true
  validates :content, presence: { message: "You must add content to your review" }
  validates_uniqueness_of :user_id, scope: [:parking_area_id], message: "You have already reviewed this parking area"

  def sum_of_votes
    sum = 0
    if votes.empty?
      0
    else
      votes.each do |vote|
        sum += vote.value
      end
    end
    sum
  end
end
