# frozen_string_literal: true

# authenticate cognito user
class RecoverPasswordService < CognitoService
  attr_reader :error

  def forgot_password
    begin
      CLIENT.forgot_password(forgot_password_object)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def forgot_password_object
    @forgot_password_object ||= {
      client_id: CLIENT_ID,
      username: @user_object[:username]
    }
  end
end
