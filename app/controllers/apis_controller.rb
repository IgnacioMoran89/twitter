class ApisController < ApplicationController

    include ActionController::HttpAuthentication::Basic::ControllerMethods
    before_action :set_tweet, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
    http_basic_authenticate_with name: "Tom Chaplin", password: "123456", only: :create_tweet

    def index
        array = []
        Tweet.all.each do |tweet|
            array << {:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :retweets_count => tweet.count_rt, :retwitted_from => tweet.user.username} 
        end
        @tweets = array
        render json: @tweets.last(50)
    end

    #formato fecha http://localhost:3000/api/2021-06-20/2021-06-30
    def between_dates
        first_date = params[:date1]
        last_date = params[:date2]
        @tweets = Tweet.where(:created_at => first_date..last_date)
        render json: @tweets
    end

    #para crear tweets desde los headers de postman
    def create_tweet
        @tweet = Tweet.new(content: request.headers["content"], user_id: request.headers["user"])
        
        if @tweet.save
            render json: @tweet, status: :created
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end


    def destroy
        @tweet.destroy
        head :no_content
    end

    private
    def set_tweet
        @tweet = Tweet.find(params[:id])
    end

    def tweet_params
        params.require(:tweet).permit(:content, :user_id)
    end
end
