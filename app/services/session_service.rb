# frozen_string_literal: true

# authenticate cognito user
class SessionService < CognitoService
  attr_accessor :user_object, :response, :role

  def initialize(user_object, role)
    @user_object = user_object
    @role = role
  end

  def authenticate
    begin
      @response = CLIENT.initiate_auth(auth_object)
      validate_user_role
    rescue StandardError => e
      @error = e
      return false
    end
    response
  end

  def sign_out
    begin
      CLIENT.global_sign_out({ access_token: user_object[:access_token] })
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def user_service
    UserService.new({ token: response.authentication_result.access_token })
  end

  def current_user_email
    user_service.logged_user_email
  end

  def user
    @user ||= UserRepository.find_by_email(current_user_email)
  end

  def validate_user_role
    raise ActiveRecord::RecordNotFound.new("The user was not found") unless user

    unless user.roles.include?(role)
      raise ActiveRecord::RecordNotFound.new("This user is not authorized to perform this action")
    end
  end

  def auth_object
    @auth_object ||= {
      client_id: CLIENT_ID,
      auth_flow: "USER_PASSWORD_AUTH",
      auth_parameters: {
        USERNAME: user_object[:username],
        PASSWORD: user_object[:password]
      }
    }
  end
end
