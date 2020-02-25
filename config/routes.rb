Rails.application.routes.draw do
  devise_for :users
  root "users#show"
  resources :items, only: [:new, :show]
end
