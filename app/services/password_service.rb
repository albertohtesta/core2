# frozen_string_literal: true

# authenticate cognito user
class PasswordService < CognitoService
  attr_reader :error

  def update_password
    begin
      resp = CLIENT.change_password(change_password_object)
    rescue StandardError => e
      @error = e
      return false
    end
    resp
  end

  def recover_password
    begin
      CLIENT.forgot_password(recover_password_object)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  def confirm_recover_password
    begin
      CLIENT.confirm_forgot_password(confirm_recover_password_object)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def change_password_object
    @change_password_object ||= {
      previous_password: @user_object[:password],
      proposed_password: @user_object[:new_password],
      access_token: @user_object[:access_token]
    }
  end

  def recover_password_object
    @recover_password_object ||= {
      client_id: CLIENT_ID,
      username: @user_object[:username]
    }
  end

  def confirm_recover_password_object
    @confirm_recover_password_object ||= {
      client_id: CLIENT_ID,
      username: @user_object[:username],
      confirmation_code: @user_object[:confirmation_code],
      password: @user_object[:password]
    }
  end
end
