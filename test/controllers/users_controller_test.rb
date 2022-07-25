# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def user
    @user ||= create(:user)
  end

  setup do
    login_as(user)
  end

  test "must return users json" do
    expected_response = {
      collection: [{ name: user.name, email: user.email, role: user.role, is_enabled: true }],
      pagination: {
        current_page: 1,
        next_page: nil,
        previous_page: nil,
        total_pages: 1,
        total_records: User.count
      }
    }

    get api_v1_users_path, headers: { "Authorization" => @token }

    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end

  test "must disable user" do
    expected_response = { message: "User was disabled" }
    patch api_v1_user_path(user),
          params: { user: { email: user.email, is_enabled: false } },
          headers: { "Authorization" => @token },
          as: :json
    response_body = JSON.parse(response.body)

    assert_response :success
    assert_not user.reload.is_enabled
    assert_equal(response_body, expected_response.as_json)
  end

  test "must enable user" do
    expected_response = { message: "User was enabled" }
    user = create(:user, is_enabled: false)
    patch api_v1_user_path(user),
          params: { user: { email: user.email, is_enabled: true } },
          headers: { "Authorization" => @token },
          as: :json
    response_body = JSON.parse(response.body)

    assert_response :success
    assert user.reload.is_enabled
    assert_equal(response_body, expected_response.as_json)
  end
end
