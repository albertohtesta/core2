# frozen_string_literal: true

require "test_helper"

class RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  def user
    @user ||= create(:user)
  end

  test "should update a role" do
    expected_response = {
      message: "Role updated"
    }
    patch api_v1_roles_path, params: { role: { email: user.email, group_name: "collaborator" } },
                             headers: { "Authorization" => @token }, as: :json

    response_body = JSON.parse(response.body)
    assert_response :success
    assert_equal(response_body, expected_response.as_json)
  end
end
