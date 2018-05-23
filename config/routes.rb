Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:show, :create, :new] do
    resources :games, only: [:show, :update, :new]
    resources :trophies, only: [:new, :show]
  end

  namespace :admin do
    resources :users, only: [:index]
    resources :trophies, only: [:new, :create, :show, :index]
  end
end
