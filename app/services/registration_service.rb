# frozen_string_literal: true

# create cognito user
class RegistrationService < CognitoService
  attr_reader :error

  def create_user
    begin
      resp = CLIENT.admin_create_user(auth_object)
      add_user_to_group
      add_user_to_table(resp)
    rescue StandardError => e
      @error = e
      CLIENT.admin_delete_user(auth_object.except(:desired_delivery_mediums)) unless persisted?
      return false
    end
    true
  end

  private

  def add_user_to_group
    CLIENT.admin_add_user_to_group(group_object)
  end

  def add_user_to_table(params)
    User.create!(
      {
        email: auth_object[:username],
        status: params.user.user_status,
        uid: params.user.username,
        role: group_object[:group_name]
      }
    )
  end

  def auth_object
    @auth_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email],
      desired_delivery_mediums: ["EMAIL"]
    }
  end

  def group_object
    @group_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email],
      group_name: @user_object[:group_name]
    }
  end

  def persisted?
    UserRepository.find_by(email: @user_object[:email])
  end
end
