class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :parking_areas
  has_many :comments
  has_many :verifications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
