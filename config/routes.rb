Rails.application.routes.draw do
  # Home
  get "/", to: "home#index"

  # Session
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # User
  get "/user_index", to: "users#index"
  get "/signup", to: "users#new"
  post "/users", to: "users#create"
end
