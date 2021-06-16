class Friend < ApplicationRecord

belongs_to :user    
belongs_to :following_user, foreign_key: 'friend_id', class_name: 'User'

end
