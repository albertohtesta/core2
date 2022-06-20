# frozen_string_literal: true

# respond to
class ChallengeService < CognitoService
  attr_reader :error

  def respond_to_auth_challenge
    begin
      CLIENT.respond_to_auth_challenge(challenge_obj)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def challenge_obj
    @challenge_obj ||= {
      client_id: CLIENT_ID,
      challenge_name: @user_object[:challenge_name],
      session: @user_object[:session],
      challenge_responses: {
        USERNAME: @user_object[:username],
        NEW_PASSWORD: @user_object[:new_password]
      }
    }
  end
end
