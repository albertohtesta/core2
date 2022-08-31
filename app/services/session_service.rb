# frozen_string_literal: true

# authenticate cognito user
class SessionService < CognitoService
  attr_reader :error, :response

  def authenticate
    begin
      response = CLIENT.initiate_auth(auth_object)
      compare_roles_with_cognito
    rescue StandardError => e
      @error = e
      return false
    end
    response
  end

  def sign_out
    begin
      CLIENT.global_sign_out({ access_token: @user_object[:access_token] })
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def user_service
    return unless response
    UserService.new({ token: response.access_token })
  end

  def current_user_email
    user_service.logged_user_email
  end

  def current_user_roles
    user_service.logged_user
  end

  def user
    @user ||= UserRepostory.find_by_email(user_email_from_access_token)
  end

  def compare_roles_with_cognito
    unless user.roles == current_user_roles
      @error = "The user is not authorized"
      false
    end
  end

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
