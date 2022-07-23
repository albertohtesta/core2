# frozen_string_literal: true

# Service to manage users status, roles, etc
class UserService < CognitoService
  attr_reader :error

  def disable_user
    begin
      CLIENT.admin_disable_user(update_user_object)
      update_user({ is_enabled: false })
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  def enable_user
    begin
      CLIENT.admin_enable_user(update_user_object)
      update_user({ is_enabled: true })
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  def logged_user_email
    logged_user[:user_attributes].find { |x| x[:name] == "email" }[:value]
  end

  private

  def user
    @user ||= User.find_by(email: @user_object[:email])
  end

  def logged_user
    stub_get_user if Rails.env.test?
    CLIENT.get_user(access_token: @user_object[:token]).to_h
  rescue StandardError => e
    @error = e
    false
  end

  def update_user(*args)
    user.update(*args)
  end

  def update_user_object
    @update_user_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email]
    }
  end
end
