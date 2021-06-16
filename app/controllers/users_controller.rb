class UsersController < ApplicationController

    def index
        @users = User.all 
    end

    def user_followers
        @user = User.where(id: params[:id]).first
        @followers = @user.get_followers
        redirect_to root_path
    end
    
    def user_following
        @user = User.where(id: params[:id]).first
        @following = @user.get_following
    end

end
