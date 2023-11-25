class ProductsController < ApplicationController
  before_action :login_only, except: %i[ index show ]
  before_action :set_product, only: %i[ show update destroy ]

  include ApplicationHelper

  # GET /api/products
  def index
    @products = Product.all
    products = @products
    render json: response_json(
      false,
      message: ShowError::SHOW_SUCCEED,
      data: {
        products: products.each do |product|
          product_detail = ProductDetail.find_by(product: product)
          seller = product.user
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            price: product.price,
            product_press: product_detail.product_press,
            product_type: product_detail.type,
            seller_name: seller.user_name,
            sell_address: product.sell_address
          }
        end
      }
    )
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
                          state: store == 0 ? "StockOut" : "Available")
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
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:price, :sell_address, :store)
    end

    def is_seller
      @product.user == current_user
    end
end
