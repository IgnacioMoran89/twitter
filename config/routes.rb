Rails.application.routes.draw do
  
  #resources :friends
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

  post '/users/:id/user_followers', to: "users#user_followers", as: "user_followers_user"

  
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
