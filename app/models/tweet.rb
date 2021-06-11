class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :content, presence: true

  acts_as_votable

  def to_s
    username
  end

  def is_retweet?
    twauthor ? true : false
  end

  def count_rt
    Tweet.where(twauthor: self.id).count
  end

  def original_tweet
    Tweet.find(self.twauthor)
  end

  
end
