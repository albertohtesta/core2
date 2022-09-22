# frozen_string_literal: true

# respond to
class ValidateUserBeforeRegisterService < ApplicationService
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def process
    if registered_user && role_taken?
      Rollbar.info(
        "ValidateUserBeforeRegisterService#process",
        message: "The user #{payload[:email]} already have this #{role} role",
        user: registered_user
      )
      return publish_failed_message("The user #{payload[:email]} already have this #{role} role")
    end

    if registered_user
      update_role
      publish_updated_message
    else
      service = RegistrationService.new(payload)
      service.create_user
      true
    end
  end

  private

  def publish_failed_message(message)
    "Users::#{role.capitalize}FailedPublisher".constantize.publish({ message: })
  end

  def publish_updated_message
    "Users::#{role.capitalize}CreatedPublisher".constantize.publish(registered_user.attributes)
  end

  def registered_user
    @registered_user ||= UserRepository.find_by_email(payload[:email])
  end

  def role
    payload[:groups_names].join
  end

  def role_taken?
    registered_user.roles.include?(role)
  end

  def update_role
    ActiveRecord::Base.transaction do
      registered_user.roles << role
      registered_user.save!
      CognitoService::CLIENT.admin_add_user_to_group(user_object)
      Rollbar.info("ValidateUserBeforeRegisterService updated role", user: registered_user)
    rescue ActiveRecord::RecordInvalid => e
      CognitoService::CLIENT.admin_remove_user_from_group(user_object)
      Rollbar.error("ValidateUserBeforeRegisterService::Error", error: e, user: registered_user, role:)
      @error = e
      return false
    end
  end

  def user_object
    @user_object ||= {
      user_pool_id: CognitoService::POOL_ID,
      username: registered_user.email,
      group_name: role
    }
  end
end
