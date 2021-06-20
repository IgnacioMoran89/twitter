class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_many :friends, class_name: "Friend", dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  acts_as_voter


end
