# frozen_string_literal: true

require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    login_as(user)
  end

  test "should update password for current user" do
    expected_response = "Password set successfully. A confirmation mail was sent."

    patch api_v1_passwords_path,
          params: { credentials: { password: "Somepassword123!", new_password: "Newpassword123!" } },
          headers: { "Authorization" => @token }

    response_body = JSON.parse(response.body)
    assert_response :success
    assert_equal(response_body["message"], expected_response)
  end
end
