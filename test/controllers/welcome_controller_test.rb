require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # test "should get index" do
  #   get root_url
  #   assert_response :found
  # end

  test "shows user's weight if already entered" do
    user = User.create(email: 'testuser@example.com', password: 'password')
    entry = WeightEntry.create(day: Date.current, value: 120, user: user)
    sign_in user

    get root_url

    assert_select 'h2', '120 lbs'
  end

  test "takes user's weight if there's no entry today" do
    user = User.create(email: 'testuser@example.com', password: 'password')
    sign_in user

    get root_url

    assert_select 'form'
  end

  test "redirects to login if the user is anonymous" do
    get root_url

    assert_redirected_to new_user_session_url
  end

  test "correctly shows weight entries for different users" do
    user_a = User.create(email: 'user1@example.com', password: 'password')
    entry_a = WeightEntry.create(day: Date.current, value: 120, user: user_a)
    user_b = User.create(email: 'user2@example.com', password: 'password')
    entry_b = WeightEntry.create(day: Date.current, value: 140, user: user_b)

    sign_in user_a
    get root_url
    assert_select 'h2', '120 lbs'

    sign_in user_b
    get root_url
    assert_select 'h2', '140 lbs'
  end

  test "associates weight entries with the correct user" do
    user = User.create(email: 'auser@example.com', password: 'password')
    sign_in user

    post weight_entries_url, {weight_entry: {value: 150}}

    assert_equal 1, user.weight_entries.count
    new_entry = user.weight_entries.first
    assert_equal 150, new_entry.value
  end
end
