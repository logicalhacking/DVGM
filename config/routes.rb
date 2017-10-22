Rails.application.routes.draw do
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lectures, only: [:index, :new, :create]
  #resource :account, :controller => "users"
  resources :users, only: [:index, :new, :create]

  #resource :user_sessions, only: [:create]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  post '/sign_in', to: 'user_sessions#create'

  resources :grades, only: [:new, :create, :index, :edit, :update]
  root to: "welcome#index"
end
