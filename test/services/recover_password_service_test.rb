# frozen_string_literal: true

require "test_helper"

class RecoverPasswordServiceTest < ActiveSupport::TestCase
  test "should assert forgot password" do
    @recover_password_service = RecoverPasswordService.new({ username: "test-registration@test.com" })

    assert(@recover_password_service.forgot_password)
  end

  test "should assert recover password with complete params" do
    @recover_password_service = RecoverPasswordService.new({ username: "test-registration@test.com",
                                                             password: "Myn3wP4$$word", confirmation_code: "785654" })

    assert(@recover_password_service.recover_password)
  end

  test "should not recover password without confirmation code " do
    registration_service = RecoverPasswordService.new(username: "test-registration@test.com", password: "Myn3wP4$$word")
    registration_service.recover_password

    assert_equal("missing required parameter params[:confirmation_code]", registration_service.error.message)
  end

  test "should not recover password without new password" do
    registration_service = RecoverPasswordService.new(username: "test-registration@test.com",
                                                      confirmation_code: "785654")
    registration_service.recover_password

    assert_equal("missing required parameter params[:password]", registration_service.error.message)
  end
end
