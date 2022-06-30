# frozen_string_literal: true

# job to add an user to an specific cognito pool group
class AddUserToAwsCognitoPoolGroupJob < ApplicationJob
  queue_as :default

  def perform(user_params)
    @user_params = user_params
    add_user_to_group
  end

  private

  def add_user_to_group
    CognitoService::CLIENT.admin_add_user_to_group(group_object)
  end

  def group_object
    @group_object ||= {
      user_pool_id: CognitoService::POOL_ID,
      username: @user_params[:email],
      group_name: @user_params[:group_name]
    }
  end
end
