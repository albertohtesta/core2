# frozen_string_literal: true

require "test_helper"

class ChallengeServiceTest < ActiveSupport::TestCase
  test "should update password for new user" do
    password_params ||= {
      username: "test-registration@test.com",
      password: "OldP4$$word",
      new_password: "Password321¡"
    }

    assert(ChallengeService.new(password_params).respond_to_change_password_challenge)
  end
end
