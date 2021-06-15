Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks do
    get :search, on: :collection
  end
  resources :labels
  resources :users, path: 'admin/users'
  root 'tasks#index'
end
