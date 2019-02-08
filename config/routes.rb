Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/projects/overdue', to: 'projects#overdue'
  resources :users, only: [:create, :destroy, :index] do
    resources :projects
  end
  resources :projects, only: [:edit, :index]
  resources :tasks, only: [:destroy, :edit, :update]
end
