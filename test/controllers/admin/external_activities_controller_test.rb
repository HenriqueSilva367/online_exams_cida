require "test_helper"

class Admin::ExternalActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_external_activities_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_external_activities_destroy_url
    assert_response :success
  end
end
