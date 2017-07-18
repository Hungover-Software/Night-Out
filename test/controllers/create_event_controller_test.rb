require 'test_helper'

class CreateEventControllerTest < ActionDispatch::IntegrationTest
  test "should get create_event" do
    get create_event_create_event_url
    assert_response :success
  end

end
