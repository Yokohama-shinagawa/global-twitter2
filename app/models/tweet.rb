class Tweet < ApplicationRecord
    validates :body, length: { in: 1..140 }
    def index
        @tweets=Tweet.where(user_id: current_user.id).page(params[:page]).order(created_at: :desc)
    end
    
    def favored?(user)
		favored_users.include?(user)
	end

    has_many :comments
    belongs_to :user
    
    has_many :favorites, dependent: :destroy
    has_many :favored_users, through: :favorites, source: :user

end
