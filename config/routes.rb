Rails.application.routes.draw do
  devise_for :users

  resources :customers do
    collection { post :import }
  end

  root to: 'customers#index'
end
