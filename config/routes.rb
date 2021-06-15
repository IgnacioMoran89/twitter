Rails.application.routes.draw do
  
  resources :follows
  resources :friends
  resources :tweets do
    post 'retweet', to: 'tweets#retweet'
    member do
      put "like", to: "tweets#like"
      put "dislike", to: "tweets#dislike"
      
    end
  end 
  
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }
  
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
