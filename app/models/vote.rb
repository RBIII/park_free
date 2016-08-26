class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user_id, presence: true
  validates :value, inclusion: {in: [-1, 0, 1]}

  def upvote(user, review)
    vote = Vote.find_or_create_by(user_id: user.id, voteable_id: review.id, voteable_type: "review")

    if vote.value == 1
      vote.value = 0
    else
      vote.value = 1
    end

    vote.save
  end

  def downvote(user, review)
    vote = Vote.find_or_create_by(user_id: user.id, voteable_id: review.id, voteable_type: "review")

    if vote.value == -1
      vote.value = 0
    else
      vote.value = -1
    end

    vote.save
  end
end
