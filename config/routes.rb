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

  # Defines the root path route ("/")
  root "games#index"
end
