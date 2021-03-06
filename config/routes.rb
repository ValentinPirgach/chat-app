Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/available_users', to: 'users#available_users'
  resources :conversations, only: [:index, :create]
  resources :messages, only: [:index, :create]
  root to: 'pages#index'
end
