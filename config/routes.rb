Rails.application.routes.draw do
  get 'create_account/new'
  post 'create_account/create'

  get 'forgot_password' => 'fp#forgot_password'
  get 'create_event' => 'create_event#create_event'

  get 'welcome/index'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
