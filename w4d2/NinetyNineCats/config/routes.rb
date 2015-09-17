Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post 'approve' => 'cat_rental_requests#approve'
      post 'deny' => 'cat_rental_requests#deny'
    end
  end
end
