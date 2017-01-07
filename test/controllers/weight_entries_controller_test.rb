require 'test_helper'

class WeightEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get weight_entries_create_url
    assert_response :success
  end

end
