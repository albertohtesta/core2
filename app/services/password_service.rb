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

  private

  def change_password_object
    @change_password_object ||= {
      previous_password: @user_object[:password],
      proposed_password: @user_object[:new_password],
      access_token: @user_object[:access_token]
    }
  end
end
