require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  root 'welcome#landing'

  resources :users, only: [:new, :create, :show]
  resources :events
  resources :posts
  resources :carts

  post 'line_items' => 'tickets#line_item_create'
  post 'order_complete' => 'carts#order_complete'

  get "users/verify", to: 'users#show_verify', as: 'verify'
  post "users/verify"
  post "users/resend"

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show]
      resources :events, only: [:show, :index]
      resources :carts, only: [:show]
      resources :posts, only: [:show]
      resources :tickets, only: [:show]
      resources :users, only: [:new, :create, :show]
      post 'line_items' => 'tickets#line_item_create'
      post 'order_complete' => 'carts#order_complete'
      get "users/verify", to: 'users#show_verify', as: 'verify'
      post "users/verify"
      post "users/resend"
    end
  end
end
