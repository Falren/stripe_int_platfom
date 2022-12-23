Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#root'
  post '/webhooks/:source', to: 'webhooks#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
