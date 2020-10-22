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

  # memo
  get "/memo", to: "memos#index"
  get "/memo_edit", to: "memos#edit"
  post "/memos", to: "memos#create"
  patch "/memo", to: "memos#update"
  delete "/memos", to: "memos#destroy"
end
