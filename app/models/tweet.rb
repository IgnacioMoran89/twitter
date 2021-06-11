class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :content, presence: true

  acts_as_votable

  def to_s
    username
  end

  
end
