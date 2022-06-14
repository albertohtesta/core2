# frozen_string_literal: true

require "test_helper"

class RegistrationServiceTest < ActiveSupport::TestCase
  setup do
    @registration_service = RegistrationService.new({ email: "test-registration@test.com", name: "test-registration" })
  end

  test "should create user" do
    assert_instance_of(Aws::CognitoIdentityProvider::Types::UserType, @registration_service.create_user.user)
  end
end
