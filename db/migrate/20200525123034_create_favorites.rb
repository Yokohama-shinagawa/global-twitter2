class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
      t.index [:user_id, :tweet_id], unique: true
    end
  end
end
