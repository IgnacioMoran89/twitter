class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :content, presence: true

  #scope :tweets_for_me, -> (user) { Tweet.where(user_id: user.friends.pluck(:friend_id).uniq) }
  
  
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
  
  def self.search_my_tweets(x)
    @my_tweets = Tweet.all #creamos variable para todos los tweets
    my_tweet_id_array = [] # transformamos los tweets en array
    @my_tweets.each do |my_tweet| #iteramos el array de tweets 
        if my_tweet.content.include? "#{x}" #si el tweet incluye el # se devuelve el contenido del tweet
            my_tweet_id_array << my_tweet.id
        end
    end
    self.where(id: my_tweet_id_array)
  end



  # Este metodo sirve para referenciar el nombre del autor del tweet pero no logro evitar que cuando el tweet original sea borrado, se caiga la app
  #def original_tweet
      #Tweet.find(self.twauthor)
  #end
  
  
end
