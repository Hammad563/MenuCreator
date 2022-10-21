Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  get "/dashboard", to: "dashboard#index"
  get "/settings", to: "settings#index"
  put "/settings", to: "settings#update"

  resources :menus, only: [:new, :create, :show, :destroy, :update]
  resources :qr_menus, only: :show
  resources :qr_codes, only: :show
end
