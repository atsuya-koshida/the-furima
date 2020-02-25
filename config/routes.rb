Rails.application.routes.draw do
  root "items#home"
  resources :items, only: [:new, :show]
end
