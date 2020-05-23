class Tweet < ApplicationRecord
    validates :body, length: { in: 1..140 }
    def index
        @tweets=Tweet.where(user_id: current_user.id).page(params[:page]).order(created_at: :desc)
    end
    has_many :comments
    belongs_to :user
end
