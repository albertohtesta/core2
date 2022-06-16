# frozen_string_literal: true

# create cognito user
class RegistrationService < CognitoService
  attr_reader :error

  def create_user
    begin
      CLIENT.admin_create_user(auth_object)
      add_user_to_group
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def add_user_to_group
    CLIENT.admin_add_user_to_group(group_object)
  end

  def auth_object
    @auth_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email],
      user_attributes:,
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

  def user_attributes
    [
      {
        name: "name",
        value: @user_object[:name]
      }
    ]
  end
end
