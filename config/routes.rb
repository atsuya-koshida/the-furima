Rails.application.routes.draw do
  devise_for :users
  root "items#home"
  resources :items, only: [:new, :create, :show, :edit] do
    collection do
      get 'purchase', to: 'items#purchase'
    end
  end
end
