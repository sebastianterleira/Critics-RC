Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  root "games#index"

  resources :critics
  resources :involved_companies
  resources :games do
    resources :critics
    post "/add_developer_game", to: "games#add_developer"
    # /games/:id/add_genre
    post "add_genre", on: :member
    # /games/:id/remove_genre
    delete "remove_genre", on: :member

    # /games/:id/add_platform
    post "add_platform", on: :member
    # /games/:id/remove_platform
    delete "remove_platform", on: :member

    # /games/:id/add_developer
    post "add_developer", on: :member

    # /games/:id/remove_developer
    delete "remove_developer", on: :member

    # /games/:id/add_publisher
    post "add_publisher", on: :member

    # /games/:id/remove_publisher
    delete "remove_publisher", on: :member
  end
  resources :platforms
  resources :genres
  resources :companies do
    resources :critics
  end
  # resources :users, only: :new

  # get "/login", to: "sessions#new"
  # post "/sessions", to: "sessions#create"
  # delete "/sessions", to: "sessions#destroy"

  # user_url
  get "/profile", to: "users#show", as: "user"
  # get "/profile", to: "users#edit"
  # patch "/profile", to: "users#update"
  # post "/profile", to: "users#create"

  # Omniauth
  # post '/auth/github', to: 'github_login'
  # get 'auth/github/callback', to: 'sessions#create'

end
