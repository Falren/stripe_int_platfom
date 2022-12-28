require 'constraints/domain_constraint'
Rails.application.routes.draw do
  get 'stores/index'
  get 'stores/show'
  devise_for :users
  post '/webhooks/:source', to: 'webhooks#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints DomainConstraint do
    scope module: :stores do
      resources :products
      resource :checkout, as: 'store_checkout'
      root to: 'products#index', as: 'store_root'
    end
  end
  root 'static_pages#root'

  resources :accounts
  resources :products
  resources :payouts, only: %i[create]
  resource :store
  resource :dashboard
  resource :checkout
  # Defines the root path route ("/")
  # root "articles#index"
end
