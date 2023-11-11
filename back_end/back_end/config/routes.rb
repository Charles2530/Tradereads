Rails.application.routes.draw do
  scope "api" do
    post :register, to: 'users#register', as: :user_register
    post :login, to: 'users#login', as: :user_login
    get :logout, to: 'users#logout', as: :user_logout
    resources :users
    resources :user_details
    resources :order_items
    resources :orders
    resources :carts
    resources :product_details
    resources :products
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
