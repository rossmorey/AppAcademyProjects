Rails.application.routes.draw do
  root to: "cats#index"
  
  resources :cats do
    resources :cat_rental_requests, only: [:edit, :show, :destroy, :update]
  end

  resources :cat_rental_requests, only: [:new, :create]
end
