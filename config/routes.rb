Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  get "/dashboard", to: "dashboard#index"
  get "/settings", to: "settings#index"
  put "/settings", to: "settings#update"
end
