require 'test_helper'

class VpControllerTest < ActionDispatch::IntegrationTest
  test "should get Voting_page" do
    get vp_Voting_page_url
    assert_response :success
  end

end
