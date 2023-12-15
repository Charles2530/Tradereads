require "test_helper"

class NoticeRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notice_record = notice_records(:one)
  end

  test "should get index" do
    get notice_records_url, as: :json
    assert_response :success
  end

  test "should create notice_record" do
    assert_difference("NoticeRecord.count") do
      post notice_records_url, params: { notice_record: { notice_id: @notice_record.notice_id, readed: @notice_record.readed, user_id: @notice_record.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show notice_record" do
    get notice_record_url(@notice_record), as: :json
    assert_response :success
  end

  test "should update notice_record" do
    patch notice_record_url(@notice_record), params: { notice_record: { notice_id: @notice_record.notice_id, readed: @notice_record.readed, user_id: @notice_record.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy notice_record" do
    assert_difference("NoticeRecord.count", -1) do
      delete notice_record_url(@notice_record), as: :json
    end

    assert_response :no_content
  end
end
