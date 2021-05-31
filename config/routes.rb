Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks do
    get :search, on: :collection
  end
  resources :labels
  root 'tasks#index'
end
