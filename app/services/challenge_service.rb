# frozen_string_literal: true

# respond to
class ChallengeService < CognitoService
  attr_reader :error

  def respond_to_change_password_challenge
    begin
      CLIENT.respond_to_auth_challenge(challenge_obj)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def session
    @session ||= CLIENT.initiate_auth(auth_object)
  end

  def challenge_obj
    @challenge_obj ||= {
      client_id: CLIENT_ID,
      challenge_name: session[:challenge_name],
      session: session[:session],
      challenge_responses: {
        USERNAME: @user_object[:username],
        NEW_PASSWORD: @user_object[:new_password]
      }
    }
  end

  def auth_object
    @auth_object ||= {
      client_id: CLIENT_ID,
      auth_flow: "USER_PASSWORD_AUTH",
      auth_parameters: {
        USERNAME: @user_object[:username],
        PASSWORD: @user_object[:password]
      }
    }
  end
end
