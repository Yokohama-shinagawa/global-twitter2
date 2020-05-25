class UsersController < ApplicationController
    before_action :users
    after_action :set_old_path, only: [:show]

	def show
		@tweets = @user.tweets.order(created_at: :desc)
	end
	
	def followings
	end

	def followers
	end


	private
        def users
            @user = User.find(params[:id])
        end
end
