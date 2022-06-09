# frozen_string_literal: true

require "test_helper"

class InfoControllerTest < ActionDispatch::IntegrationTest
  setup do
    get "/build_info"
  end

  test "should get build_info" do
    assert_response :success
  end

  test "should get build_info body" do
    expected_response = {
      build_id: "#BUILD_ID#",
      build_date: "#BUILD_DATE#",
      build_branch: "#BUILD_BRANCH#"
    }
    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
