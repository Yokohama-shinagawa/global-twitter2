class TweetsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:top]
	before_action :correct_user, only: [:edit, :update, :destroy]
	after_action :set_old_path, only: [:top, :index]
	
    def new
    	@tweet = Tweet.new
	end
	
	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id
		if @tweet.save
			redirect_to tweets_path
		else
			render 'tweets/new'
		end
	end
	
	def index
		following = current_user.followings.pluck(:following_id)
		@tweets = Tweet.where("user_id IN (?) or user_id = ?", following, current_user.id).order(created_at: :desc).page(params[:page]).per(5)
	end
	
	def show
		@tweet = Tweet.find(params[:id])
		if session[:request_from]
			@back = session[:request_from]
		else
			@back = root_path
		end
	end
	def edit
		@tweet = Tweet.find(params[:id])
	end
	def update
		if @tweet.update(tweet_params)
			redirect_to tweet_path(@tweet)
		else
			render 'tweets/edit'
		end
	end
	def destroy
		@tweet.destroy
		redirect_to tweets_path
	end
	def top
		@tweets = Tweet.order(created_at: :desc).page(params[:page]).per(5)
	end
	
	private
		def tweet_params
			params.require(:tweet).permit(:body, :user_id)
		end
		def correct_user
			@tweet = Tweet.find(params[:id])
			redirect_to tweet_path(@tweet) unless @tweet.user == current_user
		end

end
