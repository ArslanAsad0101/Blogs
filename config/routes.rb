Rails.application.routes.draw do
 devise_for :users

  root "home#index"

  get "dashboard", to: "home#dashboard"

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end
end
