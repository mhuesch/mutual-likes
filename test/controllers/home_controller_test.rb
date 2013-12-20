require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get likes" do
    get :likes
    assert_response :success
  end

end
