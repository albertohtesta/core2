# frozen_string_literal: true

require "test_helper"

class RegistrationServiceTest < ActiveSupport::TestCase
  test "should create user" do
    @registration_service = RegistrationService.new({ email: "test-registration@test.com", name: "test-registration",
                                                      group_name: "test" })
    assert(@registration_service.create_user)
  end

  test "should not create user without email" do
    registration_service = RegistrationService.new(name: "test", group_name: "test")
    registration_service.create_user

    assert_equal("missing required parameter params[:username]", registration_service.error.message)
  end

  test "should not create user without group" do
    registration_service = RegistrationService.new(email: "test-registration@test.com")
    registration_service.create_user

    assert_equal("missing required parameter params[:group_name]", registration_service.error.message)
  end
end
