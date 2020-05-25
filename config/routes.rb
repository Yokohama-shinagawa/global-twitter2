Rails.application.routes.draw do
  root to: "tweets#top"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets do
  	resources :comments, except: [:index, :show]
  	resource :favorites, only: [:create, :destroy]
    collection do
      	get :top
    end
    member do
      get :favored_by
    end
  end
  
  resources :users, only: [:show] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :fav
      get :followings
      get :followers
    end
  end

  
end
