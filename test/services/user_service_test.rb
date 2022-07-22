# frozen_string_literal: true

require "test_helper"

class UserServiceTest < ActiveSupport::TestCase
  test "should disable user" do
    user = create(:user)
    @user_service = UserService.new({ email: user.email })

    assert(@user_service.disable_user)
    assert_not user.reload.is_enabled
  end

  test "should enable user" do
    user = create(:user, is_enabled: false)
    @user_service = UserService.new({ email: user.email })

    assert(@user_service.enable_user)
    assert user.reload.is_enabled
  end
end
