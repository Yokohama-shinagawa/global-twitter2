class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :tweets
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :following
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :favorites, dependent: :destroy
  has_many :favoring_tweets, through: :favorites, source: :tweet


  def follow(other_user)
    unless self == other_user
      active_relationships.find_or_create_by(following_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = active_relationships.find_by(following_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end
  
  def favor(tweet)
    favorites.find_or_create_by(tweet_id: tweet.id)
  end
  
  def unfavor(tweet)
    favorite = favorites.find_by(tweet_id: tweet.id)
    favorite.destroy if favorite
  end
  def favoring?(tweet)
    favoring_tweets.include?(tweet)
  end


end
