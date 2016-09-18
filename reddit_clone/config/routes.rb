Rails.application.routes.draw do
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create]
  root "subs#index"
end
