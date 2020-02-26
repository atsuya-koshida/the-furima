Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users
  root "items#home"
  resources :items, only: [:new, :show, :edit] do
    collection do
      get 'purchase', to: 'items#purchase'
    end
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
  
  get 'categories/itemsindex', to: 'categories#itemsindex'
  resources :categories, only: [:index]
end
