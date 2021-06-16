class Friend < ApplicationRecord
    belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
    belongs_to :following, foreign_key: 'friend_id', class_name: 'User'
end
