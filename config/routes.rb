Rails.application.routes.draw do
  get 'create_account/create'

  get 'welcome/index'

  root 'welcome#index'
  
  match ':controller(/:action(/:id))(.:format)'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
