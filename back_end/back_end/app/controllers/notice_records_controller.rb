class NoticeRecordsController < ApplicationController
  before_action :set_notice_record, only: %i[ show update destroy ]

  # GET /notice_records
  # GET /notice_records.json
  def index
    @notice_records = NoticeRecord.all
  end

  # GET /notice_records/1
  # GET /notice_records/1.json
  def show
  end

  # POST /notice_records
  # POST /notice_records.json
  def create
    @notice_record = NoticeRecord.new(notice_record_params)

    if @notice_record.save
      render :show, status: :created, location: @notice_record
    else
      render json: @notice_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notice_records/1
  # PATCH/PUT /notice_records/1.json
  def update
    if @notice_record.update(notice_record_params)
      render :show, status: :ok, location: @notice_record
    else
      render json: @notice_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notice_records/1
  # DELETE /notice_records/1.json
  def destroy
    @notice_record.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice_record
      @notice_record = NoticeRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_record_params
      params.require(:notice_record).permit(:notice_id, :user_id, :readed)
    end
end
