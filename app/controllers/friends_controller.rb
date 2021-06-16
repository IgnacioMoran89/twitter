class FriendsController < ApplicationController

def create  
    @friend = Friend.create(user_id: current_user.id, friend_id: params[:user_id])
    redirect_to root_path
end 

def show
    @friends = Friend.all
end



private




end
