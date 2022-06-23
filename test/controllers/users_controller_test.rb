# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def user
    @user ||= create(:user)
  end

  test "must return users json" do
    expected_response = {
      collection: [{ name: user.name, email: user.email, role: user.role }],
      pagination: {
        current_page: 1,
        next_page: nil,
        previous_page: nil,
        total_pages: 1,
        total_records: User.count
      }
    }

    get api_v1_users_path

    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
