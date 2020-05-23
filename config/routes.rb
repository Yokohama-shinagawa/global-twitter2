Rails.application.routes.draw do
  root to: "tweets#top"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets do
  	resources :comments, except: [:index, :show]
    collection do
      	get :top
    end
  end
  
  resources :users, only: [:show] 

  
end
