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
    service = ::Cognito::CreateUserService.call(email: context.email)
    context.fail!(error: service.error) if service.failure?
    service
  end

  def register_user
    uuid = create_cognito_user.user_created.user.username

    service = RegisterUserService.call(email: context.email, role: context.role, uuid:)
    context.fail!(error: service.error) if service.failure?
    @user = service.user
  end

  def add_user_to_cognito_role
    service = ::Cognito::AddUserToRoleService.call(email: context.email, role: context.role)
    context.fail!(error: service.error) if service.failure?
  end

  def publish_by_user_role
    if user && !(context.role == "admin")
      "Users::#{context.role.capitalize}CreatedPublisher".constantize.publish(user.attributes)
    end
  end
end
