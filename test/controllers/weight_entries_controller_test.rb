require 'test_helper'

class WeightEntriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "associates weight entries with the current user" do
    user = User.create(email: 'auser@example.com', password: 'password')
    sign_in user

    post weight_entries_url, params: {weight_entry: {value: 150}}

    assert_equal 1, user.weight_entries.count
    new_entry = user.weight_entries.first
    assert_equal 150, new_entry.value
  end

  test "shows all entries on index" do
    Timecop.freeze('2018-08-14'.to_time) do
      user = User.create(email: 'auser@example.com', password: 'password')
      WeightEntry.destroy_all
      WeightEntry.create(user: user, value: 124, day: 0.days.ago)
      WeightEntry.create(user: user, value: 125, day: 1.days.ago)
      WeightEntry.create(user: user, value: 126, day: 2.days.ago)
      WeightEntry.create(user: user, value: 127, day: 3.days.ago)
      sign_in user

      get weight_entries_url

      rows = css_select "table tr"
      row = ->(n) { css_select(rows[n], 'td').map(&:text) }
      assert_equal ['Today', '124 lbs'], row[0]
      assert_equal ['Yesterday', '125 lbs'], row[1]
      assert_equal ['Sunday', '126 lbs'], row[2]
      assert_equal ['Saturday', '127 lbs'], row[3]
    end
  end
end
