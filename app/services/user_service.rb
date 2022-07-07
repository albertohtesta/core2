# frozen_string_literal: true

# enabled or disabled user
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

  private

  def user
    @user ||= User.find_by(email: @user_object[:email])
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
