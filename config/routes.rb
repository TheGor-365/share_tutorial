Rails.application.routes.draw do
  resources :tutorials
  root "landing#index"
  resources :landing, only: [:index, :show]
  devise_for :users
end
