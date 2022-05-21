require "test_helper"

class Admin::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_maps_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_maps_edit_url
    assert_response :success
  end
end
