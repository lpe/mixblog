Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resource :logins, only: [:new, :create, :destroy]
  resource :registrations, only: [:new, :create]

end
