Rails.application.routes.draw do
  scope "api" do
    post :register, to: 'users#register', as: :user_register
    post :login, to: 'users#login', as: :user_login
    get :logout, to: 'users#logout', as: :user_logout
    get :show_cart, to: 'users#show_cart', as: :user_show_cart
    get :show_current_orders, to: 'users#show_current_orders', as: :user_show_current_orders
    get :carts_to_orders, to: 'users#carts_to_orders', as: :user_carts_to_orders
    resources :users do
      post :modify_username, to: 'users#modify_username', as: :user_modify_username
      post :modify_address, to: 'users#modify_address', as: :user_modify_address
      post :modify_password, to: 'users#modify_password', as: :user_modify_password
      get :show_product_list, to: 'users#show_product_list', as: :user_show_product_list
    end
    resources :user_details
    resources :order_items
    resources :orders
    resources :carts
    resources :product_details
    resources :products do
      post :modify_store, to: 'products#modify_store', as: :product_modify_store
      post :modify_price, to: 'products#modify_price', as: :product_modify_price
      post :modify_sell_address, to: 'products#modify_sell_address', as: :product_modify_sell_address
      post :add_product_to_cart, to: 'products#add_product_to_cart', as: :product_add_product_to_cart
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
