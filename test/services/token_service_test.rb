# frozen_string_literal: true

require "test_helper"

class TokenServiceTest < ActiveSupport::TestCase
  setup do
    stub_cognito_uri
  end

  test "should decode valid token" do
    token_service = TokenService.new({ token: @token })

    assert(token_service.decode)
  end

  test "should not decode invalid token" do
    token_service = TokenService.new({ token: "11111.222222.333333" })

    assert_not(token_service.decode)
  end
end
