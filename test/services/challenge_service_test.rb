# frozen_string_literal: true

require "test_helper"

class ChallengeServiceTest < ActiveSupport::TestCase
  test "should update password for new user" do
    password_params ||= {
      challenge_name: "NEW_PASSWORD_REQUIRED",
      username: "test-registration@test.com",
      new_password: "Password321¡"
    }

    assert(ChallengeService.new(password_params).respond_to_auth_challenge)
  end
end
