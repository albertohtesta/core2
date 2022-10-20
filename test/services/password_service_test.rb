# frozen_string_literal: true

require "test_helper"

class PasswordServiceTest < ActiveSupport::TestCase
  test "should update password" do
    @password_service = PasswordService.new({ password: "Somepassword123!", new_password: "Newpassword123!",
                                              access_token: "1z34s6t8g" })

    assert(@password_service.update_password)
  end

  test "should not update password without password" do
    @password_service = PasswordService.new({ new_password: "Newpassword123!", access_token: "1z34s6t8g" })
    @password_service.update_password

    assert_equal("missing required parameter params[:previous_password]", @password_service.error.message)
  end

  test "should not update password without new_password" do
    @password_service = PasswordService.new({ password: "Somepassword123!", access_token: "1z34s6t8g" })
    @password_service.update_password

    assert_equal("missing required parameter params[:proposed_password]", @password_service.error.message)
  end

  test "should not update password without access_token" do
    @password_service = PasswordService.new({ password: "Somepassword123!", new_password: "Newpassword123!" })
    @password_service.update_password

    assert_equal("missing required parameter params[:access_token]", @password_service.error.message)
  end

  test "should assert forgot password" do
    user = create(:user, roles: ['admin'])
    @recover_password_service = PasswordService.new({ username: user.email })

    assert(@recover_password_service.recover_password)
  end

  test "should assert recover password with complete params" do
    @recover_password_service = PasswordService.new({ username: "test-registration@test.com",
                                                      password: "Myn3wP4$$word", confirmation_code: "785654" })

    assert(@recover_password_service.confirm_recover_password)
  end

  test "should not recover password without confirmation code " do
    registration_service = PasswordService.new(username: "test-registration@test.com", password: "Myn3wP4$$word")
    registration_service.confirm_recover_password

    assert_equal("missing required parameter params[:confirmation_code]", registration_service.error.message)
  end

  test "should not recover password without new password" do
    registration_service = PasswordService.new(username: "test-registration@test.com",
                                               confirmation_code: "785654")
    registration_service.confirm_recover_password

    assert_equal("missing required parameter params[:password]", registration_service.error.message)
  end
end
