class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  # before_action :set_per_page, only: [:index]
  # before_action :set_page, only: [:index]

  # POST /api/register
  def register
    if User.find_by(phone: params[:phone])
      render json: response_json(
        false,
        message: RegisterError::EXISTED_USER
      ) and return
    end

    user = User.new(phone: params[:phone], right: 0)
    user_detail = UserDetail.new(user: user,
                                 password: params[:password],
                                 user_name: params[:user_name],
                                 gender: params[:gender])
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

  # GET /api/users
  def index
    @users = User.all

    render json: @users
  end

  # GET /api/users/1
  def show
    user = User.find_by(params[:id])
    user_detail = UserDetail.find_by(user: user)
    render status: 200, json: response_json(
      true,
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
        params.require(:user).permit(:user_id, :user_password)
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
