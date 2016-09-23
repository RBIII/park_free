class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user_id, presence: true
  validates :value, inclusion: {in: [-1, 0, 1]}

  def upvote(user, review)
    if self.value == 1
      self.value = 0
    else
      self.value = 1
    end

    self.save
  end

  def downvote(user, review)
    if self.value == -1
      self.value = 0
    else
      self.value = -1
    end

    self.save
  end
end
