Rails.application.routes.draw do
  get 'create_account/new'
  post 'create_account/create'
  post 'welcome/login_attempt'
  match 'index', to: 'welcome#index', via: 'get'
  #get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
