class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy]

  #before_action :authenticate_user!

  # GET /tweets or /tweets.json
  def index
    @users = User.where.not(id: current_user&.id)
    @tweet = Tweet.new
    @tweets = Tweet.all.page(params[:page])

    
    if params[:q]
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").page(params[:page])
      if @tweets.nil?
        @tweets = Tweet.all.page(params[:page])
      end
    else
      @tweets = Tweet.all.page(params[:page])
    end
    

    #def index
      #if params[:q]
        #@tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").page(params[:page])
        #if @tweets.nil?
          #@tweets = Tweet.tweets_for_me(current_user).page(params[:page])
        #end
      #else
        #@tweets = Tweet.tweets_for_me(current_user).page(params[:page])
      #end
    #end
    
    if signed_in?
      @tweets = Tweet.tweets_for_me(current_user).page(params[:page])
    else
      @tweets = Tweet.all.order("created_at DESC").page(params[:page])
    end

    if params[:tweetsearch].present?
      @tweets = Tweet.search_my_tweets(params[:tweetsearch]).page(params[:page]).order("created_at DESC")
    elsif params[:hashtag].present?
      @tweets = Tweet.search_my_tweets("##{params[:hashtag]}").page(params[:page]).order("created_at DESC")
    end

  end

  # GET /tweets/1 or /tweets/1.json
  def show
    @tweets = Tweet.all
    @tweet = Tweet.find(params[:id])
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end 
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.liked_by current_user
    redirect_to root_path
  end
  
  def dislike
    @tweet = Tweet.find(params[:id])
    @tweet.disliked_by current_user
    redirect_to root_path
  end

  def retweet
    if current_user
      @tweet = Tweet.find(params[:tweet_id])
      Tweet.create(content: @tweet.content , user_id: current_user.id, twauthor: @tweet.id)
    else
      redirect_to new_user_session_path
    end
    redirect_to root_path
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :twauthor, :user_id)
    end
end
