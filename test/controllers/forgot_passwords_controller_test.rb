# frozen_string_literal: true

require "test_helper"

class ForgotPasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "should send code for forgot password" do
    expected_response = {
      message: "Password recovery email sent"
    }

    post api_v1_forgot_passwords_path,
         params: { credentials: { username: "test-registration@test.com" } },
         as: :json

    response_body = JSON.parse(response.body)

    assert_response :success
    assert_equal(response_body, expected_response.as_json)
  end
end
