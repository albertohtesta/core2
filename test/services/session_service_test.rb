# frozen_string_literal: true

require "test_helper"

class SessionServiceTest < ActiveSupport::TestCase
  setup do
    @session_service = SessionService.new({ username: "test-registration@test.com", password: "Password123!" })
  end

  test "should authenticate user" do
    assert_instance_of(Aws::CognitoIdentityProvider::Types::AuthenticationResultType,
                       @session_service.authenticate.authentication_result)
  end
end
