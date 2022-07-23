# frozen_string_literal: true

require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "admin should be able to invite and create user" do
    user = create(:user)
    login_as(user)

    expected_response = {
      message: "Invitation sent successfully"
    }

    post api_v1_registrations_path,
          params: { email: "test@test.com", name: "test", group_name: "collaborator" },
          headers: { "Authorization" => @token },
          as: :json

    response_body = JSON.parse(response.body)
    assert_response :success
    assert_equal(response_body, expected_response.as_json)
  end

  test "non admin should not be able to invite and create user" do
    user = create(:user, role: "collaborator")
    login_as(user)

    expected_response = {
      message: "You are not authorized to perform this action"
    }
    post api_v1_registrations_path,
          params: { email: "test@test.com", name: "test", group_name: "collaborator" },
          headers: { "Authorization" => @token },
          as: :json

    response_body = JSON.parse(response.body)
    assert_response :unauthorized
    assert_equal(response_body, expected_response.as_json)
  end
end
