Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #resources :friends
  resources :tweets do
    post 'retweet', to: 'tweets#retweet'
    member do
      put "like", to: "tweets#like"
      put "dislike", to: "tweets#dislike"  
    end
  end 

  get 'users/show'
  post'users/show'
  #get 'tweets/index'
  
  
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'follow/:id', to: 'friends#follow', as: 'follow_user'
    delete 'follow/:id', to: 'friends#unfollow', as: 'unfollow_user'
  end

  get '/api/news', to: 'apis#index'
  get "/api/:date1/:date2", to: 'apis#between_dates'
  get '/api/create', to: 'apis#create_tweet'
  
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
