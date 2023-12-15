class NoticesController < ApplicationController
  before_action :set_notice, only: %i[ show update destroy ]

  include ApplicationHelper

  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all
    user = current_user
    notices = []
    @notices.each do |notice|
      if user.followings.include? notice.user
        notices << notice
      elsif notice.user.right == 1
        notices << notice
      end
    end

    render status: 200, json: response_json(
      true,
      message: Global::SUCCESS,
      data: {
        notices: notices.collect do |notice|
          {
            notice_type: notice.type,
            notice_user_id: notice.user_id,
            notice_user_name: notice.user.user_detail.user_name,
            notice_title: notice.title,
            notice_content: notice.content,
            notice_create_time: notice.created_at
          }
        end
      }
    )
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
  end

  # POST /notices
  # POST /notices.json
  def create
    if current_user.right != 1
      render json: response_json(
        false,
        message: Global::UNAUTHORIZED
      ) and return
    end
    user = current_user
    title = params[:title]
    content = params[:content]
    notice = Notice.new(title: title, notice_type: 1, user: user, content: content)
    if notice.save
      render status: 200, json: response_json(
        true,
        message: Global::SUCCESS,
        data: {
          notice_id: notice.id,
          notice_create_time: notice.created_at
        }
      )
    else
      render status: 200, json: response_json(
        true,
        message: Global::FAIL
      )
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    if @notice.update(notice_params)
      render :show, status: :ok, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @notice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_params
      params.require(:notice).permit(:title, :notice_type, :user_id, :content)
    end
end
