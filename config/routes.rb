Rails.application.routes.draw do
  devise_for :users
  root "items#home"
  resources :items, only: [:new, :show]
  get 'categories/itemsindex', to: 'categories#itemsindex'
  resources :categories, only: [:index]
end
