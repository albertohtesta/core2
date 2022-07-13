# frozen_string_literal: true

# create cognito user
class RegistrationService < CognitoService
  attr_reader :error

  def create_user
    begin
      user.save!
      resp = CLIENT.admin_create_user(auth_object)
      add_user_to_table(resp)
      AddUserToAwsCognitoPoolGroupJob.perform_later(@user_object)
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def user
    @user ||= User.new({
      email: auth_object[:username],
      role: @user_object[:group_name]
    })
  end

  def add_user_to_table(params)
    user.update!(
      {
        uid: params.user.username,
        role: @user_object[:group_name]
      }
    )
  end

  def auth_object
    @auth_object ||= {
      user_pool_id: POOL_ID,
      username: @user_object[:email],
      desired_delivery_mediums: ["EMAIL"],
      user_attributes: [{ name: "email", value: @user_object[:email] }, { name: "email_verified", value: "true" }]
    }
  end
end
