class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :login_only


  include ApplicationHelper
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render :show, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      render :show, status: :ok, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    comment = Comment.find(params[:id])
    if comment.user != current_user && current_user.right != 1
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    product = comment.product
    if product.comments.length == 1
      product.score_per = 0.0
    else
      product.score_per = (product.score_per * product.comments.length - comment.score) / (product.comments.length - 1).to_f
    end

    if comment.destroy
      product.save
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
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :product_id, :content, :score)
    end
end
