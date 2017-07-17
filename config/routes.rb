Rails.application.routes.draw do
  get 'create_account' => 'create_account#new'
  post 'create_account/create'
  
  #get 'home/:id'
  post 'home/send_friend_request'
  get 'home/friends'

  get 'welcome/index'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
