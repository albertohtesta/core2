# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should user login and receive token" do
    post api_v1_sessions_path,
         params: { username: "test-registration@test.com", password: "otroP4$ssword" },
         as: :json

    assert_response :success
  end

  test "should user logout" do
    delete api_v1_sessions_path,
           headers: { "Authorization" => "1s34s6t8g" }

    assert_response :success
  end
end
