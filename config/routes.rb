Rails.application.routes.draw do
 
 root 'pages#home'
 
 resources :topics do
  resources:comments, only: [:create, :destroy]
  member do
   post 'like'
  end
 end
 resources :users
 
 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/login', to: 'sessions#destroy'
 
 mount ActionCable.server => '/cable'
 
end
