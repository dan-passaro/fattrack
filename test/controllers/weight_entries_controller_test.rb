require 'test_helper'

class WeightEntriesControllerTest < ActionDispatch::IntegrationTest
  test "associates weight entries with the current user" do
    user = User.create(email: 'auser@example.com', password: 'password')
    sign_in user

    post weight_entries_url, {weight_entry: {value: 150}}

    assert_equal 1, user.weight_entries.count
    new_entry = user.weight_entries.first
    assert_equal 150, new_entry.value
  end
end
