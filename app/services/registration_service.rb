# frozen_string_literal: true

# create cognito user
class RegistrationService < CognitoService
  def create_user
    CLIENT.admin_create_user(auth_object)
  end

  private

  def auth_object
    @auth_object ||= {
      user_pool_id: ENV.fetch("AWS_COGNITO_POOL_ID", nil),
      username: @user_object[:email],
      user_attributes:,
      desired_delivery_mediums: ["EMAIL"]
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
