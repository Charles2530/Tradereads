class OrdersController < ApplicationController
  before_action :login_only
  before_action :set_order, only: %i[ show update destroy ]

  include ApplicationHelper

  # GET /orders
  def index
    user = current_user
    if user.right == 0
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    total_prices = []
    @orders = Order.all
    orders = @orders
    orders.each do |order|
      total_price = 0
      order.order_items.each do |item|
        product = item.product
        price = product.price
        total_price += price * item.number
      end
      total_prices << total_price
    end
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        orders: total_prices.length.times do |i|
          order = orders[i]
          {
            order_id: order.id,
            buyer_id: order.user_id,
            total_price: total_prices[i],
            items: order.order_items.each do |item|
              product = item.product
              product_detail = ProductDetail.find_by(product: product)
              seller = product.user
              seller_detail = UserDetail.find_by(user: seller)
              {
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

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    user = current_user
    if user.right == 0
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    if @order.destroy
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id)
    end
end