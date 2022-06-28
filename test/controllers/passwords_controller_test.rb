# frozen_string_literal: true

require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should update a password for new user" do
    expected_response = {
      message: "Password updated"
    }
    post api_v1_passwords_path,
         params: { credentials: { username: "test-registration@test.com", password: "otroP4$ssword",
                                  new_password: "Password321¡" } },
         as: :json

    response_body = JSON.parse(response.body)
    assert_response :success
    assert_equal(response_body, expected_response.as_json)
  end
end
