Rails.application.routes.draw do
  resources :genres
  resources :platforms
  resources :involved_companies
  resources :critics, only: :destroy
  resources :games do
    resources :critics
  end
  resources :companies do
    resources :critics
  end
  resources :users
# ==============RUTAS  ANIDADAS DE PAULO=========================
  # resources :feedbacks, only: :destroy

  # # POST /employees/:employee_id/feedbaacks
  # resources :employees do
  #   resources :feedbacks, only: :create
  # end

  # resources :departments do
  #   resources :feedbacks, only: :create
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    # /games/:id/add_genre
    post "add_genre", on: :member
    # /games/:id/remove_genre
    delete "remove_genre", on: :member

    # /games/:id/add_platform
    post "add_platform", on: :member
    # /games/:id/remove_platform
    delete "remove_platform", on: :member
  end
  resources :platforms
  resources :genres
  resources :companies do
    resources :critics
  end
  resources :users, only: :new

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get "/profile", to: "users#edit"
  patch "/profile", to: "users#update"
  post "/profile", to: "users#create"
  
end
