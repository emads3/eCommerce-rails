Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'home/index'
  get 'shopping_carts/show' , to:'shopping_carts#show'
  get 'shopping_carts/:product' , to:'shopping_carts#index'
  get 'shopping_carts/destroy/:product' , to:'shopping_carts#destroy'
  get 'shopping_carts/create' , to:'shopping_carts#create'
  
  resources :categories
  resources :brands
  resources :products
  resources :orders
 
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
