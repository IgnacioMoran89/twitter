ActiveAdmin.register User do

 
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_photo
  
  actions :all

  index do

    column "name" do |user|
      user.username
    end
    
    column "Tweets" do |user|
      user.tweets.count
    end

    column "Likes" do |user|
      #user.tweets.likes.count
    end

    column "Retweets" do |user|
      user.tweets.where.not(twauthor: id).count
    end

    column "Follows" do |user|
      user.friends.count
    end
    
    actions
  end
end
