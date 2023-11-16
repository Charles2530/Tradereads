class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :login_only, except: %i[ show register login show_product_list ]
  before_action :unlogin_only, only: %i[ register ]
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
    pay_type = "Alipay"
    user_detail = UserDetail.new(user: user,
                                 password: params[:password],
                                 user_name: params[:user_name],
                                 gender: gender,
                                 pay_type: pay_type)
    if user.valid? and user_detail.valid?
      user.save
      user_detail.save
      session[:current_userid] = user.id
      render status: 200, json: response_json(
        true,
        message: RegisterError::REGISTER_SUCCESS
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

    user_detail = UserDetail.find_by(user: user)
    unless user_detail.password == _password
      render json: response_json(
        false,
        message: LoginError::WRONG_PASSWORD_PROVIDED
      ) and return
    end

    session[:current_userid] = user.id
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
    session.delete(:current_userid)
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS
    )
  end

  # POST /api/users/<user_id>/modify_username
  def modify_username
    user = @user
    user_detail = UserDetail.find_by(user: user)
    user_detail.user_name = params[:user_name]
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
    user = @user
    user_detail = UserDetail.find_by(user: user)
    user_detail.buy_address = params[:new_address]
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
    user = @user
    user_detail = UserDetail.find_by(user: user)
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

  # GET /api/show_cart
  def show_cart
    user = current_user
    total_price = 0
    user.carts.collect do |cart|
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
          {
            product_id: product.id,
            product_name: product_detail.product_name,
            seller_name: product.user_id,
            product_number: cart.number
          }
        end
      }
    )
  end

  # GET /api/users/<user_id>/show_product_list
  def show_product_list
    user = @user
    unless user
      render json: response_json(
        success: false,
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
            product_name: product_detail.product_name,
            product_image: product_detail.product_image,
            price: product.price
          }
        end
      }
    )
  end

  # GET /api/users
  def index
    unless is_admin
      render json: response_json(
        success: false
      ) and return
    end
    @users = User.all
    render status: 200, json: response_json(
      true,
      data: @users
    )
  end

  # GET /api/users/1
  def show
    user = @user
    unless user
      render json: response_json(
        false,
        message: ShowError::SHOW_FAIL
      ) and return
    end
    user_detail = UserDetail.find_by(user: user)
    render status: 200, json: response_json(
      true,
      message: ShowError::SHOW_SUCCEED,
      data: {
        phone: user.phone,
        user_name: user_detail.username,
        buy_address: user_detail.buy_address,
        gender: user_detail.gender,
        pay_type: user_detail.pay_type
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
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:user_id, :password)
      end

      def is_admin
        current_user && current_user.right == 1
      end

      # def _to_i(param, default_no = 1)
      #   param && param&.to_i > 0 ? param&.to_i : default_no.to_i
      # end
      #
      # # api/users?page=1
      # def set_page
      #   @page      = _to_i(params[:page], 1)
      #   @page      = set_per_page * (@page - 1)
      # end
      #
      # # api/users?per_page=10
      # def set_per_page
      #   @per_page  = _to_i(params[:per_page], 10)
      # end
end
