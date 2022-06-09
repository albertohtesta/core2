# frozen_string_literal: true

require 'test_helper'

class InfoControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/build_info'
  end

  test 'should get build_info' do
    assert_response :success
  end

  test 'should get build_info body' do
    expected_response = {
      build_id: 'test 1',
      build_date: 'test 2',
      build_branch: 'test 3'
    }
    response_body = JSON.parse(response.body)
    assert_equal(response_body, expected_response.as_json)
  end
end
