Rails.application.routes.draw do
  resource :users, only: [:create]
  resource :snippets, only: [:index, :create, :update, :destroy]
  post "/login", to: "users#login"
  post "/authenticate", to: "users#authenticate"
end
