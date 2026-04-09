require "test_helper"

class Admin::ExerciseAuthorizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_exercise_authorizations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_exercise_authorizations_destroy_url
    assert_response :success
  end
end
