# frozen_string_literal: true

require "test_helper"

class ForgotPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should send code for forgot password" do
    expected_response = {
      status: "ok",
      code: 200,
      message: "Password recovery email sent"
    }

    post api_v1_forgot_passwords_path,
         params: { credentials: { username: "test-registration@test.com" } },
         as: :json

    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
