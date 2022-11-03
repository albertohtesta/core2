# frozen_string_literal: true

class RegistrationService
  include Interactor

  attr_accessor :user

  def call
    register_user
    add_user_to_cognito_role
    publish_by_user_role
  end

  private

  def create_cognito_user
    service = ::Cognito::CreateUserService.call(email: context.email, role: context.role)

    if service.failure?
      Rollbar.error("Cognito::CreateUserService", error: service.error)
      context.fail!(error: service.error) if service.failure?
    end
    service
  end

  def register_user
    uuid = create_cognito_user.user_created.user.username

    service = RegisterUserService.call(email: context.email, role: context.role, uuid:)
    if service.failure?
      Rollbar.error("RegisterUserService", error: service.error)
      context.fail!(error: service.error) if service.failure?
    end
    @user = service.user
  end

  def add_user_to_cognito_role
    service = ::Cognito::AddUserToRoleService.call(email: context.email, role: context.role)
    if service.failure?
      Rollbar.error("Cognito::AddUserToRoleService", error: service.error)
      context.fail!(error: service.error) if service.failure?
    end
  end

  def publish_by_user_role
    if user && (context.role == "client" || context.role == "collaborator")
      Rollbar.info("BeforePublish", user: user.attributes, role: context.role.capitalize)
      "Users::#{context.role.capitalize}CreatedPublisher".constantize.publish(user.attributes)
    end
  end
end
