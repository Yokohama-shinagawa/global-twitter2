class CommentsController < ApplicationController
	before_action :correct_user, only: [:edit, :update, :destroy]
    def new
		@tweet = Tweet.find(params[:tweet_id])
		@comment = Comment.new
	end
	
	def create
		@tweet = Tweet.find(params[:tweet_id])
		@comment = current_user.comments.new(comment_params)
		@comment.tweet_id = @tweet.id
		if @comment.save
			redirect_to tweet_path(@tweet)
		else
			render :new
		end
	end
	
	def edit
		@tweet = Tweet.find(params[:tweet_id])
		@comment = Comment.find(params[:id])
	end
	
	def update
		if @comment.update(comment_params)
			flash[:success] = 'コメントを変更しました。'
			redirect_to tweet_path(tweet)
		else
			flash.now[:danger] = 'コメントを変更できませんでした。'
			render 'comments/edit'
		end
	end
	
	def destroy
		@comment.destroy
		flash[:success] = 'コメントを削除しました。'
		redirect_to tweet_path(tweet)
	end



	private
		def comment_params
			params.require(:comment).permit(:body, :tweet_id)
		end
		
		def correct_user
			@comment = current_user.comments.find(params[:id])
			@tweet = Tweet.find(params[:tweet_id])
			redirect_to tweet_path(@tweet) unless @comment.user == current_user
		end

end
