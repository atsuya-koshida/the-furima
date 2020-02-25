Rails.application.routes.draw do
  root "items#edit"
  resources :items, only: [:new, :show, :edit]
end
