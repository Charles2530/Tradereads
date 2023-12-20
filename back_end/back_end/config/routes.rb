Rails.application.routes.draw do
  scope "api" do
    resources :notice_records
    resources :notices
    resources :comments
    resources :followships
    get :wallet, to: 'wallets#show_wallet', as: :show_wallet
    post :wallet_charge, to: 'wallets#wallet_charge', as: :wallet_charge
    post :register, to: 'users#register', as: :user_register
    post :login, to: 'users#login', as: :user_login
    get :logout, to: 'users#logout', as: :user_logout
    get :show_cart, to: 'users#show_cart', as: :user_show_cart
    post :choose_cart_to_order, to: 'users#choose_cart_to_order', as: :user_choose_cart_to_order
    get :show_current_orders, to: 'users#show_current_orders', as: :user_show_current_orders
    get :show_sell_orders, to: 'users#show_sell_orders', as: :user_show_sell_orders
    get :carts_to_orders, to: 'users#carts_to_orders', as: :user_carts_to_orders
    get :have_new_notice, to: 'notices#have_new_notice', as: :notice_have_new_notice
    resources :users do
      post :upload_avatar, to: 'upload#upload_avatar', as: :user_upload_avatar
      post :modify_username, to: 'users#modify_username', as: :user_modify_username
      post :modify_address, to: 'users#modify_address', as: :user_modify_address
      post :modify_password, to: 'users#modify_password', as: :user_modify_password
      post :modify_pay_type, to: 'users#modify_pay_type', as: :user_modify_pay_type
      get :show_product_list, to: 'users#show_product_list', as: :user_show_product_list
      get :follow_user, to: 'users#follow_user', as: :follow_user
      get :follow_list, to: 'users#follow_list', as: :follow_list
      get :if_follow, to: 'users#if_follow', as: :if_follow
    end
    resources :user_details
    resources :order_items do
      post :modify_order_item_state, to: 'order_items#modify_state', as: :modify_order_item_state
    end
    resources :orders
    resources :carts
    resources :product_details

    post :show_products, to: 'products#show_products', as: :show_products
    scope "products" do
      get :check_product, to: 'products#get_product_list', as: :product_check_list
    end
    resources :products do
      post :modify_store, to: 'products#modify_store', as: :product_modify_store
      post :modify_price, to: 'products#modify_price', as: :product_modify_price
      post :modify_sell_address, to: 'products#modify_sell_address', as: :product_modify_sell_address
      post :add_product_to_cart, to: 'products#add_product_to_cart', as: :product_add_product_to_cart
      post :buy_product, to: 'products#buy_product', as: :buy_product
      post :add_comment, to: 'products#add_comment', as: :product_add_comment
      get :show_comments, to: 'products#show_comments', as: :product_show_comments
      post :check_product, to: 'products#check_product', as: :product_check
    end

  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
