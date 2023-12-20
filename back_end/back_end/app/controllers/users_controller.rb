class UsersController < ApplicationController
  before_action :login_only, except: %i[ register login ]
  before_action :setAdmin
  # before_action :unlogin_only, only: %i[ register ]
  # before_action :set_per_page, only: [:index]
  # before_action :set_page, only: [:index]

  include ApplicationHelper

  public

  # POST /api/register
  def register
    if User.find_by(phone: params[:phone])
      render json: response_json(
        false,
        message: RegisterError::EXISTED_USER
      ) and return
    end

    user = User.new(phone: params[:phone], right: 0)
    gender = params[:gender] || "male"
    pay_type = "alipay"
    user_detail = UserDetail.new(user: user,
                                 password: params[:password],
                                 user_name: params[:user_name],
                                 gender: gender,
                                 pay_type: pay_type)
    wallet = Wallet.new(user: user, money_sum: 0.0)
    if user.valid? and user_detail.valid? and wallet.valid?
      user.save
      wallet.save
      user_detail.save
      set_current_user(User.find(user.id))
      puts "register ------------------------------ #{current_user.id}"
      render status: 200, json: response_json(
        true,
        message: RegisterError::REGISTER_SUCCESS,
        data:{
          user_id: user.id
        }
      )
    else
      render json: response_json(
        false,
        message: RegisterError::INVALID_INFORMATION
      )
    end
  end

  # POST /api/login
  def login
    _phone = params[:phone]
    _password = params[:password]
    unless _phone || _password
      render json: response_json(
        false,
        message: LoginError::NO_VALID_INFORMATION_PROVIDED,
        ) and return
    end

    user = User.find_by(phone: params[:phone])
    unless user
      render json: response_json(
        false,
        message: LoginError::USER_NOT_EXISTED
        ) and return
    end

    user_detail = user.user_detail
    unless user_detail.password == _password
      render json: response_json(
        false,
        message: LoginError::WRONG_PASSWORD_PROVIDED
      ) and return
    end

    set_current_user(User.find(user.id))
    puts "--------------#{current_user.id}---------------------"
    render status: 200, json: response_json(
      true,
      message: LoginError::LOGIN_SUCCESS,
      data: {
        user_id: user.id,
        user_name: user_detail.user_name,
        right: user.right
      }
    )
  end

  # GET /api/logout
  def logout
    set_current_user(nil)
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS
    )
  end

  # POST /api/users/<user_id>/modify_username
  def modify_username
    @user = User.find(params[:user_id])
    user = @user
    user_detail = user.user_detail
    if params[:new_username]
      user_detail.user_name = params[:new_username]
    end
    if user_detail.save
      render status: 200, json: response_json(
        true,
        message: ModifyUserError::MODIFY_USERNAME_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: ModifyUserError::MODIFY_USERNAME_FAIL
      )
    end
  end

  # POST /api/users/<user_id>/modify_address
  def modify_address
    @user = User.find(params[:user_id])
    user = @user
    user_detail = user.user_detail
    if params[:new_address]
      user_detail.buy_address = params[:new_address]
    end
    if user_detail.save
      render status: 200, json: response_json(
        true,
        message: ModifyUserError::MODIFY_ADDRESS_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: ModifyUserError::MODIFY_ADDRESS_FAIL
      )
    end
  end

  # POST /api/users/<user_id>/modify_password
  def modify_password
    @user = User.find(params[:user_id])
    user = @user
    puts "modify_password-------------#{user.id}"
    user_detail = user.user_detail
    if user_detail.password != params[:old_password]
      render json: response_json(
        false,
        message: ModifyUserError::MODIFY_PASSWORD_WRONG_PASSWORD
      )
    else
      user_detail.password = params[:new_password]
      if user_detail.save
        render status: 200, json: response_json(
          true,
          message: ModifyUserError::MODIFY_PASSWORD_SUCCEED
        )
      else
        render json: response_json(
          false,
          message: ModifyUserError::MODIFY_PASSWORD_FAIL
        )
      end
    end
  end

  def modify_pay_type
    @user = User.find(params[:user_id])
    user = @user
    user_detail = user.user_detail
    if params[:pay_type]
      user_detail.pay_type = params[:pay_type]
    end
    if user_detail.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS
      )
    else
      render json: response_json(
        false,
        message: Global::FAIL
      )
    end
  end

  # GET /api/show_cart
  def show_cart
    user = current_user
    total_price = 0
    user.carts.each do |cart|
      product = cart.product
      price = product.price
      total_price += price * cart.number
    end
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        total_price: total_price,
        products: user.carts.collect do |cart|
          product = cart.product
          product_detail = ProductDetail.find_by(product: product)
          seller = product.user
          detail = seller.user_detail
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            seller_name: detail.user_name,
            product_price: product.price,
            product_number: cart.number
          }
        end
      }
    )
  end

  # GET /api/users/<user_id>/show_product_list
  def show_product_list
    @user = User.find(params[:user_id])
    user = @user
    unless user
      render json: response_json(
        false,
        message: ProductError::SHOW_PRODUCT_LIST_FAIL
      ) and return
    end
    render status: 200, json: response_json(
      true,
      message: ProductError::SHOW_PRODUCT_LIST_SUCCEED,
      data: {
        products: user.products.collect do |product|
          product_detail = ProductDetail.find_by(product: product)
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            product_store: product.store,
            sell_address: product.sell_address,
            price: product.price,
            check_state: transfer_state(product.check_state)
          }
        end
      }
    )
  end


  def carts_to_orders
    user = current_user
    carts = []
    order = Order.new(user: current_user)
    puts order
    unless order.valid?
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    order_items = []
    user.carts.each do |cart|
      carts << cart
      state = "待支付"
      order_item = OrderItem.new(product: cart.product, number: cart.number, state: state, order: order)
      if order_item.valid?
        order_items << order_item
      else
        render json: response_json(
          false,
          message: Global::FAIL
        ) and return
      end
    end

    order.save
    order_items.length.times do |i|
      carts[i].destroy
      order_items[i].save
    end
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS
    )
  end

  def choose_cart_to_order
    user = current_user
    cart_ids = params[:choose_carts]
    carts = []
    cart_ids.each do |cart_id|
      carts << Cart.find(cart_id)
    end
    puts "------------------------------#{params}"
    puts "-------------------------------#{carts}"
    order = Order.new(user: user)
    unless order.valid?
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    order_items = []
    carts.carts.each do |cart|
      state = "待支付"
      order_item = OrderItem.new(product: cart.product, number: cart.number, state: state, order: order)
      if order_item.valid?
        order_items << order_item
      else
        render json: response_json(
          false,
          message: Global::FAIL
        ) and return
      end
    end

    order.save
    order_items.length.times do |i|
      carts[i].destroy
      order_items[i].save
    end
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS
    )
  end

  def show_current_orders
    user = current_user
    total_prices = []
    puts user.orders.length
    user.orders.each do |order|
      total_price = 0
      order.order_items.each do |item|
        product = item.product
        price = product.price
        total_price += price * item.number
      end
      total_prices << total_price
    end
    i = 0
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        orders: user.orders.collect do |order|
          i += 1
          {
            order_id: order.id,
            total_price: total_prices[i-1],
            order_time: order.created_at.to_s,
            items: order.order_items.collect do |item|
              product = item.product
              product_detail = ProductDetail.find_by(product: product)
              seller = product.user
              seller_detail = seller.user_detail
              {
                order_item_id: item.id,
                product_image: product_detail.product_image,
                product_name: product_detail.product_name,
                sell_address: product.sell_address,
                seller_name: seller_detail.user_name,
                buy_num: item.number,
                product_price: product.price * item.number,
                state: item.state
              }
            end
          }
        end
      }
    )
  end

  def show_sell_orders
    user = current_user
    order_items = []
    # sell_orders = OrderItem.select('OrderItem.').joins(:products).where("products.user_id == ?", user.id)
    OrderItem.each do |order_item|
      product = order_item.product
      if product.user == user
        order_items << order_item
      end
    end

    puts order_items.length
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        order_items: order_items.collect do |order_item|
          order = order_item.order
          product = order_item.product
          {
            order_id: order.id,
            order_item_id: order_item.id,
            order_item_number: order_item.number,
            order_item_state: order_item.state,
            product_id: product.id,
            product_name: product.product_detail.product_name,
            product_price: product.price,
            buyer_id: order.user_id,
            order_item_time: order_item.created_at.to_s,
            order_item_total_price: product.price * order_item.number
          }
        end
      }
    )
  end

  def follow_user
    user = User.find(params[:user_id])
    if current_user == user
      render json: response_json(
        false,
        message: FollowError::CANNOT_FOLLOW_SELF
      ) and return
    end
    if Followship.find(user: current_user, following_user: user)
      followship = Followship.find(user: current_user, following_user: user)
      if followship.destroy
        render status: 200, json: response_json(
          false,
          message: Global::SUCCESS
        )
      else
        render json: response_json(
          false,
          message: Global::FAIL
        )
      end
    end
    followship = Followship.new(user: current_user, following_user: user)
    if followship.save
      render status: 200, json: response_json(
        false,
        message: Global::SUCCESS
      )
    else
      render json: response_json(
        false,
        message: Global::FAIL
      )
    end
  end

  def follow_list
    user = User.find(params[:user_id])
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        followings: user.followings.collect do |following_user|
          following_user_detail = following_user.user_detail
          {
            following_user_id: following_user.id,
            following_user_name: following_user_detail.user_name
          }
        end
      })
  end

def if_follow
  user = User.find(params[:user_id])
  render status: 200, json: response_json(
    true,
    message: ShowError::SHOW_SUCCEED,
    data: {
      if_follow: (User.find(user: current_user, following_user: user) != null)
    })
end

  # GET /api/users
  def index
    unless is_admin
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    @users = User.all
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        users: @users.collect do |user|
          user_detail = user.user_detail
          {
            user_id: user.id,
            user_phone: user.phone,
            user_name: user_detail.user_name
          }
        end
      }
    )
  end

  # GET /api/users/1
  def show
    @user = User.find(params[:id])
    user = @user
    unless user
      render json: response_json(
        false,
        message: ShowError::SHOW_FAIL
      ) and return
    end
    user_detail = user.user_detail
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        phone: user.phone,
        avatar: user_detail.avatar,
        user_name: user_detail.user_name,
        buy_address: user_detail.buy_address,
        gender: user_detail.gender,
        pay_type: user_detail.pay_type,
        right: user.right
      }
    )
  end

  # POST /api/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    #   HTTP Status Code : 422
    end
  end

  # PATCH/PUT /api/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    #   HTTP Status Code : 422
    end
  end

  # DELETE /api/users/1
  def destroy
    @user.destroy
  end

  private
      # Use callbacks to share common setup or constraints between actions.

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:user_id, :password)
      end

      def is_admin
        current_user && current_user.right == 1
      end

      def transfer_state(state)
        if state == 1
          true
        else
          false
        end

      end
end
