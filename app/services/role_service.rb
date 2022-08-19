# frozen_string_literal: true

# authenticate cognito user
class RoleService < CognitoService
  attr_reader :error

  def update_role
    begin
      remove_user_from_group
      add_user_to_group
      update_db_role
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def user
    @user ||= User.find_by(email: @user_object[:email])
  end

  def remove_user_from_group
    user.roles.each do |role|
      CLIENT.admin_remove_user_from_group(update_user_object.merge(group_name: role))
    end
  end

  def add_user_to_group
    @user_object[:groups_names].each do |role|
      CLIENT.admin_add_user_to_group(update_user_object.merge(group_name: role))
    end
  end

  def update_db_role
    user.update(roles: @user_object[:groups_names])
  end

  def update_user_object
    @update_user_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email]
    }
  end
end
