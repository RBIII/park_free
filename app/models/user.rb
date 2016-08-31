class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ratyrate_rater
  has_many :parking_areas
  has_many :comments
  has_many :reviews
  has_many :verifications, dependent: :destroy
  has_many :votes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  def get_score
    return self.comments * 2 + self.parking_areas * 5 + self.votes * 0.5
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

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
    vote = Vote.find_by(user_id: self, voteable_id: review.id, voteable_type: "review")

    vote != nil && vote.value == 1
  end

  def downvoted?(review)
    vote = Vote.find_by(user_id: self, voteable_id: review.id, voteable_type: "review")

    vote != nil && vote.value == -1
  end
end
