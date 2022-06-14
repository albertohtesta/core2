# frozen_string_literal: true

require "test_helper"

class SessionServiceTest < ActiveSupport::TestCase
  setup do
    @session_service = SessionService.new({ USERNAME: "test-registration@test.com", PASSWORD: "Password123!" })
  end

  test "should authenticate user" do
    assert_instance_of(Aws::CognitoIdentityProvider::Types::AuthenticationResultType,
                       @session_service.authenticate.authentication_result)
  end
end
