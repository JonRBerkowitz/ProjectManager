Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :users, only: [:show, :create, :index, :destroy] do
    resources :lists
  end
  resources :lists, only: [:edit]
  resources :tasks, only: [:destroy, :edit, :update]
end
