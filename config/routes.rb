Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'create_account' => 'create_account#new'
  post 'create_account/create'
  
  #get 'home/:id'
  post 'home/send_friend_request'
  post 'home/respond_to_friend_request'
  get 'friends', to: 'home#friends'
  get 'home', to: 'home#index'

  get 'forgot_password' => 'fp#forgot_password'
  get 'create_event' => 'create_event#create_event'

  post 'welcome/login_attempt'
  match 'index', to: 'welcome#index', via: 'get'
  #get 'welcome/index'
  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
