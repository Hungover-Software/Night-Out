Rails.application.routes.draw do
  get 'home_page/landing_page'

  get 'create_event/create_event'

  get 'fp/forgot_password'
 
  get 'create_account/new'
  post 'create_account/create'

  get 'welcome/index'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
