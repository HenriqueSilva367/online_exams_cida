require "test_helper"

class ExamSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exam_sessions_index_url
    assert_response :success
  end

  test "should get show" do
    get exam_sessions_show_url
    assert_response :success
  end
end
