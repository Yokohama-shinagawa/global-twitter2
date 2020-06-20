class FavoritesController < ApplicationController
    def create
		tweet = Tweet.find(params[:tweet_id])
		current_user.favor(tweet)
		redirect_back(fallback_location: root_path)
	end

	def destroy
		tweet = Tweet.find(params[:tweet_id])
		current_user.unfavor(tweet)
		redirect_back(fallback_location: root_path)
	end
	
	


end
