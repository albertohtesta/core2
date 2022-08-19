# frozen_string_literal: true

# job to add an user to an specific cognito pool group
class AddUserToAwsCognitoPoolGroupJob < ApplicationJob
  queue_as :default

  def perform(user_params)
    @user_params = user_params
    add_user_to_groups
  end

  private

  def add_user_to_groups
    group_objects.each do |group_object|
      CognitoService::CLIENT.admin_add_user_to_group(group_object)
    end
  end

  def group_objects
    @user_params[:groups_object].map do |role|
      {
        user_pool_id: CognitoService::POOL_ID,
        username: @user_params[:email],
        group_name: role
      }
    end
  end
end
