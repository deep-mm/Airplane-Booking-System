Rails.application.routes.draw do
  root 'welcome#index'
  resources :baggages
  resources :cities
  resources :flights
  resources :reservations
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get '*path' => redirect('/')
end
