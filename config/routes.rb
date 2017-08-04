Rails.application.routes.draw do
  

  get 'vp/Voting_page'
  get 'vp/new'

  get 'create_account' => 'create_account#new'
  post 'create_account/create'
  
  #get 'home/:id'
  post 'home/send_friend_request'
  get 'home/friends'

  get 'forgot_password' => 'fp#forgot_password'
  get 'create_event' => 'create_event#create_event'

  post 'welcome/login_attempt'
  match 'login', to: 'welcome#index', via: 'get'
  #get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
