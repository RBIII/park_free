class User < ActiveRecord::Base
  has_many :parking_areas
  has_many :comments
  has_many :reviews
  has_many :verifications, dependent: :destroy
  has_many :votes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        uid: access_token["uid"],
        provider: access_token["provider"]
      )
    end
    user
  end

  def upvoted?(review)
    vote = Vote.find_by(user_id: self.id, voteable_id: review.id, voteable_type: "Review")

    return vote != nil && vote.value == 1
  end

  def downvoted?(review)
    vote = Vote.find_by(user_id: self.id, voteable_id: review.id, voteable_type: "Review")

    return vote != nil && vote.value == -1
  end

  def get_score
    comments * 2 + parking_areas * 5 + votes * 0.5
  end
end
