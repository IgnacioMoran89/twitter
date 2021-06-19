ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_photo
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :profile_photo, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :username, :email, :user_id
    
    
    actions :all
  
    permit_params :username, :email, :user_id

  index do
		column 'User name', :username

    column 'Number of users followed' do |user|
			user.friends.count
		end
	
		column 'Tweets quantity' do |user|
			user.tweets.count
		end

		column 'Likes quantity' do |user|
			user.likes.count
		end
		
    column :retweets do |user|
        user.tweets.where.not(twauthor: id).count
  
    end

		actions
	end
	
  
  end
