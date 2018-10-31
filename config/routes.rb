Rails.application.routes.draw do
 
 root 'pages#home'
 
 resources :topics do
  resources:comments, only: [:create]
 end
 resources :users
 
 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/login', to: 'sessions#destroy'
 
 mount ActionCable.server => '/cable'
 
end
