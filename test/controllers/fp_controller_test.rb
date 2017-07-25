require 'test_helper'

class FpControllerTest < ActionDispatch::IntegrationTest
  test "should get forgot_password" do
    get fp_forgot_password_url
    assert_response :success
  end

end
