require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "Should_be_visit_MyBragDocument_page" do
    get profile_path
    assert_response :success
  end
end
