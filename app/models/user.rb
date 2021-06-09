class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true 
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  def to_s
    username
  end
end
