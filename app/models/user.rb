class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :free_parking_areas
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
