class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_many :friends, dependent: :destroy

  has_many :follower_relationships, foreign_key: :friend_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :user_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following





  validates :email, presence: true, uniqueness: true
  acts_as_voter

  def to_s
    username
  end
end
