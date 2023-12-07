class ProductsController < ApplicationController
  before_action :login_only, except: %i[ index show ]
  before_action :setAdmin

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
            price: product.price,
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
    @products = Product.all
    show_following = params[:show_following]
    show_order_base = params[:show_order_base]
    show_order = params[:show_order]
    # if show_following and show_order_base
    #   products = Product.where.associated(:user,
    # end

    if show_order_base
      products = Product.order(:price)
      if show_order == "DESC"
        products = Product.order(price: :desc)
      end
    else
      products = Product.all
    end
    render json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        products: products.where(check_state: 1).collect do |product|
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
            sell_address: product.sell_address
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
    render status: 200, json: response_json(
      true,
      message: ProductError::SHOW_PRODUCT_SUCCEED,
      data: {
        product_name: product_detail.product_name,
        product_press: product_detail.product_press,
        product_price: product.price,
        product_state: product.state,
        seller_name: seller.username,
        seller_phone: seller.phone
      }
    )
  end

  # POST /api/products/<product_id>/modify_store
  def modify_store
    @product = Product.find(params[:product_id])
    product = @product
    unless is_seller
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
    @product = Product.find(params[:product_id])
    product = @product
    unless is_seller
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
    @product = Product.find(params[:product_id])
    product = @product
    puts is_seller
    unless is_seller
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
    cart = Cart.find_by(user: buyer, product: product)
    if cart
      cart.number += count
    else
      cart = Cart.new(user: buyer, product: product, number: count)
    end

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

  def add_comment
    @product = Product.find(params[:product_id])
    product = @product
    content = params[:content]
    score = params[:score]

    comment = Comment.new(product: product, user: current_user, content: content, score: score)

    if comment.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS,
        data: {
          comment_id: comment.id,
          date: comment.created_at
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
    product.check_state = 1
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
                          check_state: 0)
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

    def is_seller
      @product.user == current_user
    end
end
