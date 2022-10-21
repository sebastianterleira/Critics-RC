Rails.application.routes.draw do
  resources :genres
  resources :platforms
  resources :involved_companies
  resources :critics
  resources :games
  resources :companies
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
