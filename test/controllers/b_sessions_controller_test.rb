require "test_helper"

class BSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get b_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get b_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get b_sessions_destroy_url
    assert_response :success
  end
end
