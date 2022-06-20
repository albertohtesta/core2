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
      client_id: CLIENT_ID,
      auth_flow: "ADMIN_NO_SRP_AUTH",
      auth_parameters: session_params
    }
  end

  def session_params
    @session_params ||= {
      USERNAME: @user_object[:username],
      PASSWORD: @user_object[:password]
    }
  end
end
