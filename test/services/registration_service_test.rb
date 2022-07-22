# frozen_string_literal: true

require "test_helper"

class RegistrationServiceTest < ActiveSupport::TestCase
  test "should create user" do
    @registration_service = RegistrationService.new({ email: "test-registration@test.com",
                                                      group_name: "collaborator" })
    assert(@registration_service.create_user)
  end

  test "should not create user without email" do
    registration_service = RegistrationService.new(group_name: "collaborator")
    registration_service.create_user

    assert_equal("Validation failed: Email can't be blank", registration_service.error.message)
  end

  test "should add user to pg database" do
    registration_service = RegistrationService.new({ email: "test-registration@test.com",
                                                     group_name: "collaborator" })

    assert_difference "User.count" do
      registration_service.create_user
    end
  end
end
