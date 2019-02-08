Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/lists/overdue', to: 'lists#overdue'
  resources :users, only: [:create, :destroy, :index] do
    resources :lists
  end
  resources :lists, only: [:edit, :index]
  resources :tasks, only: [:destroy, :edit, :update]
end
