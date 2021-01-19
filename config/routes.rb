Rails.application.routes.draw do
  devise_for :users

  resources :customers do
    collection { post :import }
  end

  resources :vehicles

  root to: 'customers#index'
end
