require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get store" do
    get pages_store_url
    assert_response :success
  end
end
