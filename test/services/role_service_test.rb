# frozen_string_literal: true

require "test_helper"

class RoleServiceTest < ActiveSupport::TestCase
  test "should update user role" do
    user = create(:user)
    @role_service = RoleService.new({ email: user.email,
                                      group_name: "collaborator" })

    assert(@role_service.update_role)
    assert_equal user.reload.role, "collaborator"
  end
end
