class FollowshipsController < ApplicationController
  before_action :set_followship, only: %i[ show update destroy ]
  before_action :login_only

  # GET /followships
  def index
    @followships = Followship.all
  end

  # GET /followships/1
  def show
  end

  # POST /followships
  def create
    @followship = Followship.new(followship_params)

    if @followship.save
      render :show, status: :created, location: @followship
    else
      render json: @followship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /followships/1
  def update
    if @followship.update(followship_params)
      render :show, status: :ok, location: @followship
    else
      render json: @followship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /followships/1
  def destroy
    @followship.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_followship
      @followship = Followship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def followship_params
      params.require(:followship).permit(:user_id, :follower_id)
    end
end
