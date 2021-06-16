class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_many :friends, dependent: :destroy
  belongs_to :friend
  
  validates :email, presence: true, uniqueness: true
  acts_as_voter

  def to_s
    username
  end

  def get_followers
    Friend.where(friend_id: self.id)
  end
  
  def get_following
    Friend.where(user_id: self.id)
  end



end
