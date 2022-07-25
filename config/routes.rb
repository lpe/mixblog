Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resource :logins, only: [:new, :create ]
  resource :registrations, only: [:new, :create]
  resources :posts
  
end
