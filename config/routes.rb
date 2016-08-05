Rails.application.routes.draw do
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts
  resources :comments
  root "subs#index"
end
