Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'create_account' => 'create_account#new'
  post 'create_account/create'
  
  #get 'home/:id'
  post 'home/send_friend_request'
  get 'home/events' => 'event#list'
  post 'home/respond_to_friend_request'
  get 'friends', to: 'home#friends'
  get 'home', to: 'home#index'

  get 'forgot_password' => 'fp#forgot_password'
  get 'new_event' => 'event#new'
  post 'create_event' => 'event#create'

  post 'welcome/login_attempt'
  match 'index', to: 'welcome#index', via: 'get'
  
  get 'events/:id/', to: 'event#show', as: 'event'
  post 'events/:id/invite', to: 'event#invite'
  post 'events/:id/accept_invite', to: 'event#accept_invite'
  post 'events/:id/decline_invite', to: 'event#decline_invite'
  post 'events/:id/add_poll', to: 'event#add_poll'
  post 'events/:id/add_option', to: 'event#add_option'
  post 'events/:id/vote', to: 'event#vote'
  post 'events/:id/destroy', to: 'event#destroy'
  post 'events/:id/remove_poll', to: 'event#remove_poll'
  
  #get 'welcome/index'
  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
end
