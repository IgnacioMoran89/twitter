Rails.application.routes.draw do
  
  #resources :friends
  resources :tweets do
    post 'retweet', to: 'tweets#retweet'
    member do
      put "like", to: "tweets#like"
      put "dislike", to: "tweets#dislike"
      
    end
  end 

  get 'users/show'
  
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'follow/:id', to: 'friends#follow', as: 'follow_user'
    delete 'follow/:id', to: 'friends#unfollow', as: 'unfollow_user'
  end


  
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
