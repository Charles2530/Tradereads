require "test_helper"

class FollowshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @followship = followships(:one)
  end

  test "should get index" do
    get followships_url, as: :json
    assert_response :success
  end

  test "should create followship" do
    assert_difference("Followship.count") do
      post followships_url, params: { followship: { follower_id: @followship.follower_id, user_id: @followship.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show followship" do
    get followship_url(@followship), as: :json
    assert_response :success
  end

  test "should update followship" do
    patch followship_url(@followship), params: { followship: { follower_id: @followship.follower_id, user_id: @followship.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy followship" do
    assert_difference("Followship.count", -1) do
      delete followship_url(@followship), as: :json
    end

    assert_response :no_content
  end
end
