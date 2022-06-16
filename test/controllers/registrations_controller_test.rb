# frozen_string_literal: true

require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should invite and create user" do
    expected_response = {
      status: "ok",
      code: 200,
      message: "Invitation sent"
    }
    post api_v1_registrations_path, params: { email: "test@test.com", name: "test", group_name: "testing_assignment" },
                                    as: :json

    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
