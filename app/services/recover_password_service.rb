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

  def recover_password
    begin
      CLIENT.confirm_forgot_password(recover_password_object)
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

  def recover_password_object
    @recover_password_object ||= {
      client_id: CLIENT_ID,
      username: @user_object[:username],
      confirmation_code: @user_object[:confirmation_code],
      password: @user_object[:password]
    }
  end
end
