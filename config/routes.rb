Rails.application.routes.draw do
  
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

  post 'follow/:user_id', to: 'users#follow', as: 'users_follow'
  
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
