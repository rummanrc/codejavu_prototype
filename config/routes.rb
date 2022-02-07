Rails.application.routes.draw do
  resource :users, only: [:create]
  resource :snippets, only: [:create, :update, :destroy]
  get "/snippets", to: "snippets#index"
  get "/snippets/:id", to: "snippets#show"
  post "/login", to: "users#login"
  post "/authenticate", to: "users#authenticate"
end
