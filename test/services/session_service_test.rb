# frozen_string_literal: true

require "test_helper"

class SessionServiceTest < ActiveSupport::TestCase
  setup do
    @session_service = SessionService.new({ username: "test-registration@test.com", password: "Password123!" })
  end

  test "should authenticate user" do
    session = @session_service.authenticate
    assert_instance_of(Aws::CognitoIdentityProvider::Types::AuthenticationResultType,
                       session.authentication_result)
  end
end
