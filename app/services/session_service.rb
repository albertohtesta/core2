# frozen_string_literal: true

# authenticate cognito user
class SessionService < CognitoService
  attr_reader :error

  def authenticate
    begin
      resp = CLIENT.initiate_auth(auth_object)
    rescue StandardError => e
      @error = e
    end
    resp
  end

  private

  def auth_object
    @auth_object ||= {
      client_id: CLIENT_ID,
      auth_flow: "USER_PASSWORD_AUTH",
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
