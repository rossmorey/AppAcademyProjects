Rails.application.routes.draw do
  root to: "cats#index"

  resources :cats do
    resources :cat_rental_requests, only: [:edit, :destroy, :update]
  end

  resources :cat_rental_requests, only: [:new, :create]

  patch "cat_rental_requests/:id", to: "cat_rental_requests#approve"
end
