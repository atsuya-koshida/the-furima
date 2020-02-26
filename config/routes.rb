Rails.application.routes.draw do
  devise_for :users
  root "items#home"
  resources :items, only: [:new, :show, :edit] do
    collection do
      get 'purchase', to: 'items#purchase'
    end
  end

  resources :card, only: [:new] do
    collection do
      get 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  
  get 'categories/itemsindex', to: 'categories#itemsindex'
  resources :categories, only: [:index]
end
