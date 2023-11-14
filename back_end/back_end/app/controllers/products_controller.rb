class ProductsController < ApplicationController
  before_action :login_only, except: %i[ index show ]
  before_action :set_product, only: %i[ show update destroy ]

  # GET /api/products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /api/products/<product_id>
  def show
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
    product = @product
    unless is_seller
      render json: response_json(
        false,
        message: ProductError::MODIFY_UNAVAILABLE
      ) and return
    end
    new_address = params[:new_sell_address]

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
    product = @product
    count = params[:count]
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

  # POST /api/products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:user_id, :price, :sell_address, :store, :state)
    end

    def is_seller
      @product.user == current_user
    end
end
