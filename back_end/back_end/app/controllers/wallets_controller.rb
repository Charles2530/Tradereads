class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show update destroy ]
  before_action :login_only

  include ApplicationHelper

  # GET /wallets
  # GET /wallets.json
  def index
    @wallets = Wallet.all
  end

  def show_wallet
    user = current_user
    wallet = user.wallet
    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        money_sum: wallet.money_sum
      }
    )
  end

  def wallet_charge
    charge_money = params[:charge_money].to_f
    user = current_user
    wallet = user.wallet
    wallet.money_sum += charge_money
    if wallet.save
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

  # GET /wallets/1
  # GET /wallets/1.json
  def show
  end

  # POST /wallets
  # POST /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render :show, status: :created, location: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wallets/1
  # PATCH/PUT /wallets/1.json
  def update
    if @wallet.update(wallet_params)
      render :show, status: :ok, location: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wallets/1
  # DELETE /wallets/1.json
  def destroy
    @wallet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:user_id, :money_sum)
    end
end
