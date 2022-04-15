require "test_helper"

class Public::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_maps_new_url
    assert_response :success
  end
end
