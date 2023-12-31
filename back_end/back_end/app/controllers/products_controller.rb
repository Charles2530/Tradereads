class ProductsController < ApplicationController
  before_action :login_only, except: %i[ index show ]

  include ApplicationHelper

  # GET /api/products
  def index
    render json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        products: Product.where(check_state: 1).collect do |product|
          product_detail = ProductDetail.find_by(product: product)
          seller = product.user
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            price: product.price.to_f,
            product_press: product_detail.product_press,
            product_type: product_detail.product_type,
            seller_name: seller.user_detail.user_name,
            sell_address: product.sell_address
          }
        end
      }
    )
  end

  def show_products
    show_following = params[:show_following]
    show_order_base = params[:show_order_base]
    show_order = params[:show_order]
    user = current_user

    if show_order_base == "price"
      if show_order == "DESC" # 降序
        products = Product.order(price: :desc)
      else # 升序 / 默认
        products = Product.order(:price)
      end
    elsif show_order_base == "comment"
      products = Product.all
      if show_order == "DESC" # 降序
        products = products.sort {|a, b| b.comments.length <=> a.comments.length }
      else # 升序 / 默认
        products = products.sort {|a, b| a.comments.length <=> b.comments.length }
      end
    elsif show_order_base == "score"
      products = Product.all
      if show_order == "DESC" # 降序
        products = products.sort {|a, b| b.score_per <=> a.score_per }
      else
        products = products.sort {|a, b| a.score_per <=> b.score_per }
      end
    else
      if show_order == "ASC" # 降序
        products = Product.order(id: :asc)
      else # 升序 / 默认
        products = Product.order(id: :desc)
      end
    end

    temp = products
    products = []
    temp.each do |product|
      if product.check_state == 1
        products << product
      end
    end

    if show_following == 1
      temp = products
      products = []
      temp.each do |product|
        if user.followings.include? product.user
          products << product
        end
      end
    end

    render json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        products: products.collect do |product|
          product_detail = ProductDetail.find_by(product: product)
          seller = product.user
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            price: product.price,
            product_press: product_detail.product_press,
            product_type: product_detail.product_type,
            seller_name: seller.user_detail.user_name,
            sell_address: product.sell_address,
            seller_id: seller.id
          }
        end
      }
    )
  end

  # GET /api/products/<product_id>
  def show
    @product = Product.find(params[:id])
    product = @product
    unless product
      render json: response_json(
        false,
        message: ProductError::SHOW_PRODUCT_FAIL
      ) and return
    end
    product_detail = ProductDetail.find_by(product: product)
    seller = User.find_by(id: product.user_id)
    puts "-------------------product_price: #{product.price}---------------------"
    render status: 200, json: response_json(
      true,
      message: ProductError::SHOW_PRODUCT_SUCCEED,
      data: {
        product_name: product_detail.product_name,
        product_image: product_detail.product_image,
        product_press: product_detail.product_press,
        price: product.price,
        product_state: product.state,
        product_type: product_detail.product_type,
        sell_address: product.sell_address,
        seller_name: seller.user_detail.user_name,
        seller_phone: seller.phone,
        seller_id: seller.id
      }
    )
  end

  # POST /api/products/<product_id>/modify_store
  def modify_store
    @product = Product.find(params[:product_id])
    product = @product
    unless product.user == current_user
      render json: response_json(
        false,
        message: ProductError::MODIFY_UNAVAILABLE
      ) and return
    end
    new_store = params[:new_store]
    product.store = new_store
    if new_store == 0
      product.state = "StockOut"
    else
      product.state = "Available"
    end
    if product.save
      render status: 200, json: response_json(
        true,
        message: ProductError::MODIFY_STORE_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: ProductError::MODIFY_STORE_FAIL
      )
    end
  end

  # POST /api/products/<product_id>/modify_price
  def modify_price
    product = Product.find(params[:product_id])

    unless product.user == current_user
      render json: response_json(
        false,
        message: ProductError::MODIFY_UNAVAILABLE
      ) and return
    end
    new_price = params[:new_price]
    product.price = new_price
    if product.save
      render status: 200, json: response_json(
        true,
        message: ProductError::MODIFY_PRICE_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: ProductError::MODIFY_PRICE_FAIL
      )
    end
  end

  # POST /api/products/<product_id>/modify_sell_address
  def modify_sell_address
    product = Product.find(params[:product_id])
    unless product.user == current_user
      render json: response_json(
        false,
        message: ProductError::MODIFY_UNAVAILABLE
      ) and return
    end
    new_address = params[:new_address]

    product.sell_address = new_address
    if product.save
      render status: 200, json: response_json(
        true,
        message: ProductError::MODIFY_ADDRESS_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: ProductError::MODIFY_ADDRESS_FAIL
      )
    end
  end

  def modify_product_name
    product = Product.find(params[:product_id])

    unless product.user == current_user
      render json: response_json(
        false,
        message: ProductError::MODIFY_UNAVAILABLE
      ) and return
    end
    new_name = params[:new_name]

    product.product_detail.product_name = new_name
    if product.save
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

  # POST /api/products/<product_id>/add_product_to_cart
  def add_product_to_cart
    @product = Product.find(params[:product_id])
    product = @product
    count = params[:count].to_i
    unless count >= 0 && count.is_a?(Integer)
      render json: response_json(
        false,
        message: CartError::ADD_FAIL
      ) and return
    end
    if count > product.store
      render json: response_json(
        false,
        message: CartError::NOT_ENOUGH_STORE
      ) and return
    end
    product.store -= count
    if product.store == 0
      product.state = "StockOut"
    end
    buyer = current_user
    if Cart.exists?(user: buyer, product: product)
      cart = Cart.find_by(user: buyer, product: product)
      cart.number += count
    else
      cart = Cart.new(user: buyer, product: product, number: count)
    end

    product.save
    if cart.save
      render status: 200, json: response_json(
        true,
        message: CartError::ADD_SUCCEED
      )
    else
      render json: response_json(
        false,
        message: CartError::ADD_FAIL
      )
    end
  end

  def remove_from_cart
    product = Product.find(params[:product_id])
    user = current_user
    unless Cart.exists?(user: user, product: product)
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    cart = Cart.find_by(user: user, product: product)
    product.store += cart.number
    product.state = "Available"
    product.save
    if cart.destroy
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

  def show_cart
    puts "-----------------#{current_user.id}----------"
    total_price = 0
    carts = Cart.where(user: current_user)
    carts.each do |cart|
      product = cart.product
      price = product.price
      total_price += price * cart.number
    end
    puts "------------------show carts #{current_user.id}"
    puts "------------------total_price #{total_price}"
    puts "------------------user.carts.length #{current_user.carts.length}"
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        total_price: total_price,
        products: carts.collect do |cart|
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

  def buy_product
    @product = Product.find(params[:product_id])
    product = @product
    count = params[:count].to_i
    unless count >= 0 && count.is_a?(Integer)
      render json: response_json(
        false,
        message: CartError::ADD_FAIL
      ) and return
    end
    if count > product.store
      render json: response_json(
        false,
        message: CartError::NOT_ENOUGH_STORE
      ) and return
    end

    buyer = current_user
    wallet = buyer.wallet

    need_price = count * product.price
    if need_price > wallet.money_sum
      render json: response_json(
        false,
        message: "余额不足"
      ) and return
    end

    wallet.money_sum -= need_price
    product.user.wallet.money_sum += need_price


    product.store -= count
    if product.store == 0
      product.state = "StockOut"
    end



    order = Order.new(user: buyer)
    unless order.valid?
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end
    state = "待发货"
    order_item = OrderItem.new(product: product, number: count, state: state, order: order)
    unless order_item.valid?
      render json: response_json(
        false,
        message: Global::FAIL
      ) and return
    end

    notice = Notice.new(title: "有新的销售记录！", notice_type: 3, user: product.user,
                        content: "#{buyer.user_detail.user_name} 购买了您的商品 #{product.product_detail.product_name}\n总计 #{count} 件，#{need_price} 元")

    product.user.wallet.save
    order.save
    order_item.save
    product.save
    wallet.save
    notice.save
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS
    )

  end

  def add_comment
    @product = Product.find(params[:product_id])
    product = @product
    content = params[:content]
    score = params[:score].to_i
    product.score_per = (product.score_per * product.comments.length + score) / (product.comments.length + 1).to_f
    comment = Comment.new(product: product, user: current_user, content: content, score: score)
    if comment.valid? and product.valid?
      comment.save
      product.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS,
        data: {
          comment_id: comment.id,
          date: comment.created_at.to_s
        }
      )
    else
      render json: response_json(
        false,
        message: Global::FAIL
      )
    end
  end

  # GET /api/products/check_product
  def get_product_list
    user = current_user
    if user.right == 0
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    @products = Product.all
    products = @products
    render json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        products: products.collect do |product|
          product_detail = ProductDetail.find_by(product: product)
          seller = product.user
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            price: product.price,
            product_press: product_detail.product_press,
            product_type: product_detail.product_type,
            seller_name: seller.user_detail.user_name,
            sell_address: product.sell_address,
            check_state: product.check_state
          }
        end
      }
    )
  end

  def show_comments
    product = Product.find(params[:product_id])
    comments = product.comments
    render json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        comments: comments.collect do |comment|
          user = comment.user
          {
            product_id: product.id,
            user_name: user.user_detail.user_name,
            content: comment.content,
            score: comment.score,
            date: comment.created_at.to_s
          }
        end
      }
    )
  end

  # POST /api/products/<product_id>/check_product
  def check_product
    user = current_user
    if user.right == 0
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    @product = Product.find(params[:product_id])
    product = @product

    check_result = params[:check_state]
    if check_result == 0
      if product.destroy
        render status: 200, json: response_json(
          true,
          message: Global::SUCCESS
        ) and return
      else
        render json: response_json(
          false,
          message: Global::FAIL
        ) and return
      end
    end
    notice = Notice.new(title: "新商品上新了", notice_type: 2, user: product.user, content: "添加了商品 #{product.product_detail.product_name}")
    product.check_state = 1
    if product.save
      notice.save
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

  # POST /api/products
def create
  seller = current_user

  price, sell_address, store = params[:price], params[:sell_address], params[:store]
  unless price || sell_address || store
    render json: response_json(
      false,
      message: ProductError::CREATE_FAIL
    ) and return
  end

  product = Product.new(user: seller,
                        price: price,
                        sell_address: sell_address,
                        store: store,
                        state: store == 0 ? "StockOut" : "Available",
                        check_state: 0,
                        score_per: 0.0)
  name, image, press, type = params[:product_name], params[:product_image], params[:product_press], params[:product_type]
  product_detail = ProductDetail.new(product: product,
                                     product_name: name,
                                     product_image: image,
                                     product_press: press,
                                     product_type: type)

  if product.valid? && product_detail.valid?
    product.save
    product_detail.save
    render status: 200, json: response_json(
      true,
      message: ProductError::CREATE_SUCCEED,
      data: {
        product_id: product.id,
        state: product.state
      }
    )
  else
    render json: response_json(
      false,
      message: ProductError::CREATE_FAIL
    )
  end
end

  # DELETE /api/products/1
  def destroy
    @product = Product.find(params[:id])
    if @product.user == current_user or current_user.right == 1
      if @product.destroy
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
    else
      render json: response_json(
        false,
        message: Global::FAIL
      )
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:price, :sell_address, :store)
    end
end
