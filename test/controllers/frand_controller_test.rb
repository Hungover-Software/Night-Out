require 'test_helper'

class FrandControllerTest < ActionDispatch::IntegrationTest
  test "should get friends" do
    get frand_friends_url
    assert_response :success
  end

end
