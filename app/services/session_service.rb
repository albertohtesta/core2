# frozen_string_literal: true

# authenticate cognito user
class SessionService < CognitoService
  def authenticate
    CLIENT.admin_initiate_auth(auth_object)
  end

  private

  def auth_object
    @auth_object ||= {
      user_pool_id: POOL_ID,
      client_id: ENV.fetch("AWS_COGNITO_CLIENT_ID", nil),
      auth_flow: "ADMIN_NO_SRP_AUTH",
      auth_parameters: @user_object
    }
  end
end
