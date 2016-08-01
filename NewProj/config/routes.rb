Rails.application.routes.draw do
  # resources :users
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show", :as => 'user'
  post "/users", to: "users#create"
  delete "/users/:id", to: "users#destroy"
  patch "/users/:id", to: "users#update"
  put "/users/:id", to: "users#update"
  get "/users/new", to: "users#new", :as => 'new_user'
  get "/users/:id/edit", to: "users#edit", :as => 'edit_user'
end
