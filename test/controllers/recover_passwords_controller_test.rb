# frozen_string_literal: true

require "test_helper"

class RecoverPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should update a password for new user" do
    expected_response = {
      status: "ok",
      code: 200,
      message: "Password recovered"
    }

    post api_v1_recover_passwords_path,
         params: { credentials: { username: "test-registration@test.com", confirmation_code: "234538",
                                  password: "Myn3wP455word" } },
         as: :json

    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
