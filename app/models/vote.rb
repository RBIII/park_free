class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user_id, presence: true
  validates :value, inclusion: {in: [-1, 0, 1]}

  def upvote(user, review)
    if value == 1
      update_attributes(value: 0)
    else
      update_attributes(value: 1)
    end
  end

  def downvote(user, review)
    if value == -1
      update_attributes(value: 0)
    else
      update_attributes(value: -1)
    end
  end

  def get_initial_state
    if value == 0
      :no_vote
    elsif value == 1
      :upvoted
    else
      :downvoted
    end
  end
end
