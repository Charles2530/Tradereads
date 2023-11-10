class ProductDetailsController < ApplicationController
  before_action :set_product_detail, only: %i[ show update destroy ]

  # GET /product_details
  def index
    @product_details = ProductDetail.all

    render json: @product_details
  end

  # GET /product_details/1
  def show
    render json: @product_detail
  end

  # POST /product_details
  def create
    @product_detail = ProductDetail.new(product_detail_params)

    if @product_detail.save
      render json: @product_detail, status: :created, location: @product_detail
    else
      render json: @product_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_details/1
  def update
    if @product_detail.update(product_detail_params)
      render json: @product_detail
    else
      render json: @product_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_details/1
  def destroy
    @product_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_detail
      @product_detail = ProductDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_detail_params
      params.require(:product_detail).permit(:product_id, :product_name, :product_image, :product_press, :product_type)
    end
end
