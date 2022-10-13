# frozen_string_literal: true

# respond to
class ValidateUserBeforeRegisterService
  include Interactor
  include Integrations::Cognito

  delegate :email, :role, to: :context

  def call
    if registered_user && role_taken?
      Rollbar.info(
        "ValidateUserBeforeRegisterService#call",
        message: "The user #{email} already have this #{role} role",
        user: registered_user
      )

      publish_failed_message("The user #{email} already have this #{role} role")
      context.fail!(error: "The user #{email} already have this #{role} role")
    end

    if registered_user
      update_role
      publish_updated_message
    else
      service = RegistrationService.call(email:, role:)
      context.fail!(error: service.error) if service.failure?
    end
  end

  private

  def publish_failed_message(message)
    "Users::#{role.capitalize}FailedPublisher".constantize.publish({ message: }) unless role == "admin"
  end

  def publish_updated_message
    "Users::#{role.capitalize}CreatedPublisher".constantize.publish(registered_user.attributes) unless role == "admin"
  end

  def registered_user
    UserRepository.find_by_email(email)
  end

  def role_taken?
    registered_user.roles.include?(role)
  end

  def update_role
    ActiveRecord::Base.transaction do
      user = registered_user
      user.roles << role
      user.save!
      add_user_to_role(email: user.email, role:)
      Rollbar.info("ValidateUserBeforeRegisterService updated role", user: registered_user)
    rescue ActiveRecord::RecordInvalid => e
      remove_user_from_role(email: user.email, role:)
      Rollbar.error("ValidateUserBeforeRegisterService::Error", error: e, user: registered_user, role:)
    end
  end
end
