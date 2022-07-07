# frozen_string_literal: true

require "test_helper"

class RecoverPasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "should update a password for new user" do
    expected_response = {
      message: "Password recovered"
    }

    post api_v1_recover_passwords_path,
         params: { credentials: { username: "test-registration@test.com", confirmation_code: "234538",
                                  password: "Myn3wP455word" } },
         as: :json

    response_body = JSON.parse(response.body)

    assert_response :success
    assert_equal(response_body, expected_response.as_json)
  end
end
