class Comment < ApplicationRecord
    belongs_to :user
	belongs_to :tweet
	validates :user_id, presence: true
	validates :tweet_id, presence: true
	validates :body, presence: true, length: { maximum: 140 }
end
