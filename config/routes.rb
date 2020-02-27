Rails.application.routes.draw do
  devise_for :users
  root "items#home"
  resources :users, only: [:show]
  resources :items, only: [:new, :create, :show, :edit] do
    collection do
      get 'category_more'
    end
    member do
      get 'purchase', to: 'items#purchase'
      get 'done', to: 'items#done'
      post 'pay', to: 'items#pay'
    end
  end

  resources :addresses, only: [:new, :create, :edit, :update]

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
