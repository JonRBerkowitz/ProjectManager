Rails.application.routes.draw do
  resources :notes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'projects#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/projects/overdue', to: 'projects#overdue'
  get '/projects/finished', to: 'projects#finished'
  resources :users, only: [:create, :destroy, :index] do
    resources :projects
  end
  resources :projects, only: [:edit, :index]
  resources :tasks, only: [:destroy, :edit, :update, :create]
end
